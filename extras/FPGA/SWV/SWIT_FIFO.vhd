----------------------------------------------------------------------------------
-- Company: 		 Trioflex OÜ
-- Engineer: 		 
-- 
-- Create Date:    15:33:01 01/26/2012 
-- Design Name: 
-- Module Name:    SWIT_FIFO - Behavioral 
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


entity SWIT_FIFO is
    Port ( reset 					: in  STD_LOGIC;
           wr_clk 				: in  STD_LOGIC;
           rd_clk 				: in  STD_LOGIC;
           din 					: in  STD_LOGIC_VECTOR (7 downto 0);
           wr_en 					: in  STD_LOGIC;
           rd_en 					: in  STD_LOGIC;
           dout 					: out STD_LOGIC_VECTOR (7 downto 0);
           full 					: out STD_LOGIC;
           empty 					: out STD_LOGIC
			  );
end SWIT_FIFO;

architecture Behavioral of SWIT_FIFO is

-- COMPONENTS --------------------------------------------------------------------
	component DP_FIFO
		port (
			rst				: IN 	std_logic;
			wr_clk			: IN 	std_logic;
			rd_clk			: IN 	std_logic;
			din				: IN 	std_logic_VECTOR(7 downto 0);
			wr_en				: IN 	std_logic;
			rd_en				: IN 	std_logic;
			dout				: OUT std_logic_VECTOR(7 downto 0);
			full				: OUT std_logic;
			empty				: OUT std_logic
		);
	end component;

	-- Synplicity black box declaration
	attribute syn_black_box : boolean;
	attribute syn_black_box of DP_FIFO: component is true;


-- CIRCUIT DESCRIPTION BEGIN -----------------------------------------------------
begin


Inst_DP_FIFO : DP_FIFO
		port map (
			rst 			=> reset,
			wr_clk 		=> wr_clk,
			rd_clk 		=> rd_clk,
			din 			=> din,
			wr_en 		=> wr_en,
			rd_en 		=> rd_en,
			dout 			=> dout,
			full 			=> full,
			empty 		=> empty
		);


end Behavioral;

