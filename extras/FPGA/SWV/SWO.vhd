----------------------------------------------------------------------------------
-- Company: 		 Trioflex OÜ
-- Engineer: 		 
-- 
-- Create Date:    16:24:01 01/25/2012 
-- Design Name: 
-- Module Name:    SWO - Behavioral 
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



entity SWO is Port ( 
   -- From APB register block
	-- Current output prescaler register
   CODR				: in  STD_LOGIC_VECTOR (12 downto 0); -- prescaler value, in serializer clock domain
	-- Protocol
   SPPR				: in  STD_LOGIC_VECTOR (1 downto 0); -- 0x01 manchester, 0x2 UART 8N1

   -- Serializer clock domain
	TRACECLKIN 		: in  STD_LOGIC; -- UART/manchester bit rate goes to prescaler first
   TRESETn 			: in  STD_LOGIC;
   TRACESWO 		: out STD_LOGIC; -- UART or manchester output
	
	-- ATB bus, Trace bus clock domain
--   ATCLK 			: in  STD_LOGIC; -- clock into fifo, rising edge
--   ATCLKEN 			: in  STD_LOGIC;
--   ATRESETn 		: in  STD_LOGIC;
   -- ATBYTES not required as max ADATA is 8 bits
   ATDATA 			: in  STD_LOGIC_VECTOR (7 downto 0); -- SWO is byte wide only
	-- ignored, not used in this module
 --  ATID 				: in  STD_LOGIC_VECTOR (6 downto 0);
	--
	ATVALID 			: in  STD_LOGIC; -- valid data present, push into fifo if possible, and ack
   ATREADY 			: out STD_LOGIC--; -- if 1 then data is accepted and pushed into fifo
   
	--
--   AFVALID 			: out STD_LOGIC;
 --  AFREADY 			: in  STD_LOGIC
	);
end SWO;


architecture Behavioral of SWO is
		
-- COMPONENTS --------------------------------------------------------------------
	COMPONENT SWO_FIFO
		PORT(
			clk 		: IN  std_logic;
			reset 	: IN 	std_logic;
			R_en 		: IN 	std_logic;
			W_data 	: IN 	std_logic_vector(7 downto 0);
			W_en 		: IN 	std_logic;          
			full 		: OUT std_logic;
			R_data 	: OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-- SIGNALS -----------------------------------------------------------------------
	signal out_sh_reg				: std_logic_vector(8 downto 0);
	signal baud_counter			: std_logic_vector(12 downto 0) := (others => '0');
	signal tx_en					: std_logic := '0';
	signal send						: std_logic := '0';
	signal nrdy						: std_logic := '0';
	signal tx_byte					: std_logic_vector(7 downto 0) := X"00";
	signal uart_o					: std_logic := '1';
	signal manch_o					: std_logic := '1';
	signal sh_en					: std_logic := '0';
	
	
-- CIRCUIT DESCRIPTION BEGIN -----------------------------------------------------
begin
	--AFVALID 			<= AFREADY; -- not supported yet, no flush requests
	
	TRACESWO			<= uart_o when(SPPR = "10") else  	-- uart mode 
							manch_o when(SPPR = "01") else 	-- manchester encoding mode
							'0';										-- others not supported
	
	manch_o			<= '1'; -- not implemented
	
	ATREADY 			<= ((not nrdy) and (not send));
	
	Inst_SWO_FIFO: SWO_FIFO PORT MAP(
		clk 			=> TRACECLKIN,
		reset 		=> TRESETn,
		full 			=> send,
		R_data 		=> tx_byte,
		R_en 			=> nrdy,
		W_data 		=> ATDATA,
		W_en 			=> ATVALID
	);



-- uart shifter
	process(TRESETn, nrdy, out_sh_reg, TRACECLKIN)
		begin		
			if(TRESETn = '1' or (sh_en = '1' and out_sh_reg = X"00")) then
				nrdy 				<= '0';
				uart_o 			<= '1';
				sh_en				<= '0';
			
			elsif rising_edge(TRACECLKIN) then
				if(nrdy = '0' and send = '1') then
					nrdy 				<= '1';
				end if;
			
				if(nrdy = '1' and tx_en = '1') then
					if(sh_en = '0') then
						out_sh_reg 		<= (tx_byte & '1');
						uart_o 			<= '0';
						sh_en				<= '1';
					else
						uart_o 			<= out_sh_reg(8);
						out_sh_reg		<= (out_sh_reg(7 downto 0) & '0');
					end if;
				end if;
			end if;
	end process;
	
-- baudrate clock enable gen	
	process(TRACECLKIN)
		begin		
			if rising_edge(TRACECLKIN) then
				baud_counter 	<= baud_counter + '1';
				tx_en 	<= '0';
				if(baud_counter = CODR) then
					baud_counter 	<= (others => '0');
					tx_en 	<= '1';
				end if;
			end if;
	end process;
	

end Behavioral;

