--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:11:59 01/26/2012
-- Design Name:   
-- Module Name:   C:/work/HW/fpga/xilinx/ARM_Cores/SWV/ITM_SWO_tb.vhd
-- Project Name:  SWV
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ITM_SWO
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY ITM_SWO_tb IS
END ITM_SWO_tb;
 
ARCHITECTURE behavior OF ITM_SWO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ITM_SWO
    PORT(
         PCLKDBG : IN  std_logic;
         PADDRDBG : IN  std_logic_vector(15 downto 0);
         PWDATADBG : IN  std_logic_vector(31 downto 0);
         PSTRBDBG : IN  std_logic_vector(3 downto 0);
         PWRITEDBG : IN  std_logic;
         TRACECLK : IN  std_logic;
         TRACESWO : OUT  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PCLKDBG : std_logic := '1';
   signal PADDRDBG : std_logic_vector(15 downto 0) := X"0000";
   signal PWDATADBG : std_logic_vector(31 downto 0) := (others => '0');
   signal PSTRBDBG : std_logic_vector(3 downto 0) := (others => '0');
   signal PWRITEDBG : std_logic := '0';
   signal TRACECLK : std_logic := '1';
   signal reset : std_logic := '1';
	signal bytecount : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal TRACESWO : std_logic;

   -- Clock period definitions
   constant TRACECLK_period : time := 10 ns;
	constant PCLKDBG_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ITM_SWO PORT MAP (
          PCLKDBG => PCLKDBG,
          PADDRDBG => PADDRDBG,
          PWDATADBG => PWDATADBG,
          PSTRBDBG => PSTRBDBG,
          PWRITEDBG => PWRITEDBG,
          TRACECLK => TRACECLK,
          TRACESWO => TRACESWO,
          reset => reset
        );

   -- Clock process definitions
   PCLKDBG_process :process
   begin
		PCLKDBG <= '1';
		wait for PCLKDBG_period/2;
		PCLKDBG <= '0';
		wait for PCLKDBG_period/2;
   end process;
 

   TRACECLK_process :process
   begin
		TRACECLK <= '1';
		wait for TRACECLK_period/2;
		TRACECLK <= '0';
		wait for TRACECLK_period/2;
   end process;

PWDATADBG   <= ((bytecount + "11") & (bytecount + "10") & (bytecount + "01") & bytecount);

   -- Stimulus process
   stim_proc: process
   begin		
			
   PSTRBDBG <= "1111";

			
      wait for PCLKDBG_period*20;
			reset <= '0';
		wait for PCLKDBG_period*10;
		
      loop
			wait for PCLKDBG_period;
			
			bytecount	<= bytecount + '1';
			PWRITEDBG   <= '1';
	   end loop;


	  

      wait;
   end process;

END;
