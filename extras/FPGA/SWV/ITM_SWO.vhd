----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:42 01/25/2012 
-- Design Name: 
-- Module Name:    ITM_SWO - Behavioral 
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


entity ITM_SWO is Port ( 
	PCLKDBG 				: in  STD_LOGIC;
   PADDRDBG 			: in  STD_LOGIC_VECTOR (15 downto 0);
   PWDATADBG 			: in  STD_LOGIC_VECTOR (31 downto 0);
   PSTRBDBG 			: in  STD_LOGIC_VECTOR (3 downto 0);
   PWRITEDBG 			: in  STD_LOGIC;
   --
	TRACECLK 			: in  STD_LOGIC;
   TRACESWO 			: out STD_LOGIC;
	reset					: in  STD_LOGIC
	);
end ITM_SWO;

architecture Behavioral of ITM_SWO is

	COMPONENT ITM_SWIT
	PORT(
		ATCLK : IN std_logic;
		ATREADY : IN std_logic;
		PCLKDBG : IN std_logic;
		PADDRDBG : IN std_logic_vector(15 downto 0);
		PWDATADBG : IN std_logic_vector(31 downto 0);
		PSTRBDBG : IN std_logic_vector(3 downto 0);
		PWRITEDBG : IN std_logic;          
		ATVALID : OUT std_logic;
		ATDATA : OUT std_logic_vector(7 downto 0);
		reset : IN  STD_LOGIC
		);
	END COMPONENT;

	COMPONENT SWO
	PORT(
		CODR : IN std_logic_vector(12 downto 0);
		SPPR : IN std_logic_vector(1 downto 0);
		TRACECLKIN : IN std_logic;
		TRESETn : IN std_logic;
	--	ATCLK : IN std_logic;
	--	ATCLKEN : IN std_logic;
	--	ATRESETn : IN std_logic;
		ATDATA : IN std_logic_vector(7 downto 0);
	--	ATID : IN std_logic_vector(6 downto 0);
		ATVALID : IN std_logic;
	--	AFREADY : IN std_logic;          
		TRACESWO : OUT std_logic;
		ATREADY : OUT std_logic--;
	--	AFVALID : OUT std_logic
		);
	END COMPONENT;

signal ATVALID: std_logic;
signal ATREADY: std_logic;
signal ATDATA: std_logic_vector(7 downto 0);


begin

	Inst_ITM_SWIT: ITM_SWIT PORT MAP(
		ATCLK 		=> TRACECLK,
		ATVALID 		=> ATVALID,
		ATREADY 		=> ATREADY,
		ATDATA 		=> ATDATA,
		
		PCLKDBG 		=> PCLKDBG,
		PADDRDBG 	=> PADDRDBG,
		PWDATADBG 	=> PWDATADBG,
		PSTRBDBG 	=> PSTRBDBG,
		PWRITEDBG 	=> PWRITEDBG,
		reset			=> reset
	);


	Inst_SWO: SWO PORT MAP(
		CODR 			=> "0000000000000", -- Prescaler
		SPPR 			=> "10", -- UART mode, ignored
		TRACECLKIN 	=> TRACECLK,
		TRESETn 		=> reset,
		TRACESWO 	=> TRACESWO,
--		ATCLK 		=> TRACECLK,
--		ATCLKEN 		=> '1',
--		ATRESETn 	=> '0',
		ATDATA 		=> ATDATA,
--		ATID 			=> "0000001", -- ignored
		ATVALID 		=> ATVALID,
		ATREADY 		=> ATREADY--,
		
--		AFVALID 		=> open,
--		AFREADY 		=> '0'
	);




end Behavioral;

