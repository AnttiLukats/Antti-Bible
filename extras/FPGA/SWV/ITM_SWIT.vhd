----------------------------------------------------------------------------------
-- Company: 		 Trioflex OÜ
-- Engineer: 		 
-- 
-- Create Date:    17:03:07 01/25/2012 
-- Design Name: 
-- Module Name:    ITM_SWIT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ITM_SWIT is Port ( 
   ATCLK 					: in  STD_LOGIC;
	ATVALID					: out STD_LOGIC;
	ATREADY					: in  STD_LOGIC;
   ATDATA 					: out STD_LOGIC_VECTOR (7 downto 0);
	
	-- APB Bus trace input
	PCLKDBG 					: in  STD_LOGIC;	
	PADDRDBG    			: in  STD_LOGIC_VECTOR (15 downto 0); -- 
	-- not in ARM spec :) !
   PWDATADBG 				: in  STD_LOGIC_VECTOR (31 downto 0); -- data in
	PSTRBDBG 				: in  STD_LOGIC_VECTOR (3 downto 0); -- 1 for byte lane to be written
   PWRITEDBG 				: in  STD_LOGIC;	-- send DATA[31..0] to ATB !
	reset						: in  STD_LOGIC
	);
end ITM_SWIT;

architecture Behavioral of ITM_SWIT is
-- COMPONENTS --------------------------------------------------------------------
	COMPONENT SWIT_FIFO
		PORT(
			reset 			: IN 	std_logic;
			wr_clk 			: IN 	std_logic;
			rd_clk 			: IN 	std_logic;
			din 				: IN 	std_logic_vector(7 downto 0);
			wr_en 			: IN 	std_logic;
			rd_en 			: IN 	std_logic;          
			dout 				: OUT std_logic_vector(7 downto 0);
			full 				: OUT std_logic;
			empty 			: OUT std_logic
		);
	END COMPONENT;


-- SIGNALS -----------------------------------------------------------------------			
	signal fifo_empty			: std_logic := '0';
	signal fifo_full 			: std_logic := '0';
	signal fifo_full_delay	: std_logic := '0';
	signal fifo_full_delay2	: std_logic := '0';
	signal fifo_wr_en			: std_logic := '0';
	signal fifo_rd_en 		: std_logic := '0';
	signal fifo_din			: std_logic_vector(7 downto 0) := X"00";
	signal fifo_dout			: std_logic_vector(7 downto 0) := X"00";
	
	
	signal fifo_in_4byte		: std_logic_vector(31 downto 0) := X"00000000";
	signal fifo_in_4s			: std_logic_vector(31 downto 0) := X"00000000";
	
	signal pacet_bytes		: std_logic_vector(1 downto 0) := "00";
	signal bytes_s				: std_logic_vector(1 downto 0) := "00";
	
	signal next_s				: std_logic := '0';
	signal send					: std_logic := '0';
	
	signal store 				: std_logic := '0';
	signal byte2 				: std_logic := '0';
	signal byte3 				: std_logic := '0';
	signal byte4 				: std_logic := '0';
	
-- CIRCUIT DESCRIPTION BEGIN -----------------------------------------------------
begin
	-- packet
	-- B0: PADDRDBG[6..2], 0, 01 when 1 byte, 10 when 2 bytes, 11 when 4 bytes  
	-- B1: 7..0
	-- B2: 15..8
	-- B3: 23..16
	-- B4: 31..24


	process(reset, ATCLK)
		begin
			if(reset = '1') then
				ATVALID 				<= '0';
				ATDATA				<= X"00";
				fifo_rd_en 			<= '0';
				next_s				<= '0';
				send					<= '0';
				
			elsif(rising_edge(ATCLK)) then
				fifo_rd_en 		<= '0';
				ATVALID 			<= '0';
				send				<= '0';
				
				-- some data is in the FIFO buffer 
				-- and transmitter is ready to send next byte
				if(fifo_empty = '0' and ATREADY = '1' and next_s = '0') then
					next_s			<= '1';
					fifo_rd_en 		<= '1';
				elsif(ATREADY = '0') then
					next_s			<= '0';
				end if;
				
				if(fifo_rd_en = '1') then
					send				<= '1';
				end if;
				
				if(send = '1') then
					ATVALID 			<= '1';
					ATDATA			<= fifo_dout;			
				end if;
			end if;
	end process;



-- FIFO ---------------------------------------------------------------------------
	Inst_SWIT_FIFO: SWIT_FIFO PORT MAP(
		reset 				=> reset,
		wr_clk				=> PCLKDBG,
		rd_clk 				=> ATCLK,
		din 					=> fifo_din,
		wr_en 				=> fifo_wr_en,
		rd_en 				=> fifo_rd_en,
		dout 					=> fifo_dout,
		full 					=> fifo_full,
		empty 				=> fifo_empty
	);

-- FIFO WRITE ---------------------------------------------------------------------		
	process(reset, PCLKDBG)
		begin
			if(reset = '1') then
				fifo_wr_en 					<= '0';
				byte2							<= '0';
				byte3							<= '0';
				byte4							<= '0';
				store 						<= '0';
				fifo_full_delay			<= '0';
				fifo_full_delay2			<= '0';
				
			elsif(rising_edge(PCLKDBG)) then
				fifo_wr_en 					<= '0';
				fifo_full_delay			<= '0';
				fifo_full_delay2 			<= '0';
				
				if(fifo_full = '1') then
					fifo_full_delay 		<= '1';
				end if;
				
				if(fifo_full = '0' and fifo_full_delay2 = '0') then
					if(fifo_full_delay = '1') then
						fifo_full_delay2 	<= '1';
					end if;
				
					if(PWRITEDBG = '1' and store = '0' and pacet_bytes /= "00") then
						store 				<= '1';
						fifo_din				<= (PADDRDBG(6 downto 2) & '0' & pacet_bytes);
						bytes_s				<= pacet_bytes;
						fifo_in_4s			<= fifo_in_4byte; 	-- store input data
						fifo_wr_en 			<= '1';
						byte2					<= '0';
						byte3					<= '0';
						byte4					<= '0';
					end if;
					
					if(store = '1') then
						fifo_wr_en 			<= '1';
						if(byte2	= '1') then
							fifo_din 		<= fifo_in_4s(15 downto 8);
							store 			<= '0';
							byte2				<= '0';
							if(bytes_s(0) = '1') then
								store 		<= '1';
							end if;
							
						elsif(byte3	= '1') then
							fifo_din 		<= fifo_in_4s(23 downto 16);
							byte3				<= '0';
						
						elsif(byte4	= '1') then
							fifo_din 		<= fifo_in_4s(31 downto 24);
							store 			<= '0';
						else
							fifo_din 		<= fifo_in_4s(7 downto 0);
							store 			<= '0';
							if(bytes_s(1) = '1') then
								store 		<= '1';
								byte2			<= '1';
								byte3			<= '1';
								byte4			<= '1';
							end if;
							
						end if;					
					end if;
				end if;	
			end if;
	end process;
	
-- INPUT MUX ----------------------------------------------------------------------
	process(PSTRBDBG, PWDATADBG)
		begin
			case(PSTRBDBG) is
				-- 4 bytes
				when "1111" =>	pacet_bytes <= "11"; fifo_in_4byte 	<= PWDATADBG;
				-- 2 bytes				
				when "0011" => pacet_bytes <= "10"; fifo_in_4byte <= (X"0000" & PWDATADBG(15 downto 0));
				-- 1 byte	
				when "0001" => pacet_bytes <= "01"; fifo_in_4byte <= (X"000000" & PWDATADBG(7 downto 0));
				-- invalid combinations
				when others => pacet_bytes <= "00"; fifo_in_4byte <= X"00000000";
			end case;
	end process;

end Behavioral;

