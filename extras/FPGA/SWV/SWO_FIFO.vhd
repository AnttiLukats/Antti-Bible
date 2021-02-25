----------------------------------------------------------------------------------
-- Company: 		 Trioflex OÜ
-- Engineer: 		 
-- 
-- Create Date:    13:03:37 01/26/2012 
-- Design Name: 
-- Module Name:    SWO_FIFO - Behavioral 
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


entity SWO_FIFO is
    Port ( 
			  clk 				: in  STD_LOGIC;
			  reset 				: in  STD_LOGIC;
           full 				: out STD_LOGIC;
			  
			  R_data 			: out STD_LOGIC_VECTOR (7 downto 0);
           R_en 				: in  STD_LOGIC;

           W_data 			: in  STD_LOGIC_VECTOR (7 downto 0);
           W_en 				: in  STD_LOGIC
			  );
end SWO_FIFO;

architecture Behavioral of SWO_FIFO is

-- SIGNALS -----------------------------------------------------------------------
	signal fifo_reg			: std_logic_vector(7 downto 0) := X"00";
	signal status				: std_logic := '0';

-- CIRCUIT DESCRIPTION BEGIN -----------------------------------------------------
begin

	full 			<= status;
	
	R_data		<= fifo_reg;
	
	process(reset, clk)
		begin
			if(reset = '1') then
				fifo_reg 		<= X"00";
				status			<= '0';
			elsif(rising_edge(clk)) then
				if(status = '0' and W_en = '1') then
					fifo_reg 		<= W_data;
					status 			<= '1';
				elsif(status = '1' and R_en = '0') then
					status 			<= '0';
				end if;
			end if;
	end process;



end Behavioral;

