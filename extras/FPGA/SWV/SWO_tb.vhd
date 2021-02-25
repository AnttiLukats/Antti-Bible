--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:36:32 01/26/2012
-- Design Name:   
-- Module Name:   C:/work/HW/fpga/xilinx/ARM_Cores/SWV/SWO_tb.vhd
-- Project Name:  SWV
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SWO
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
 
ENTITY SWO_tb IS
END SWO_tb;
 
ARCHITECTURE behavior OF SWO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SWO
    PORT(
         CODR : IN  std_logic_vector(12 downto 0);
         SPPR : IN  std_logic_vector(1 downto 0);
         TRACECLKIN : IN  std_logic;
         TRESETn : IN  std_logic;
         TRACESWO : OUT  std_logic;
 --        ATCLK : IN  std_logic;
 --        ATCLKEN : IN  std_logic;
 --        ATRESETn : IN  std_logic;
         ATDATA : IN  std_logic_vector(7 downto 0);
--         ATID : IN  std_logic_vector(6 downto 0);
         ATVALID : IN  std_logic;
         ATREADY : OUT  std_logic--;
--         AFVALID : OUT  std_logic;
--         AFREADY : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CODR : std_logic_vector(12 downto 0) := "0000000000000";
   signal SPPR : std_logic_vector(1 downto 0) := "10";
   signal TRACECLKIN : std_logic := '1';
   signal TRESETn : std_logic := '1';
--   signal ATCLK : std_logic := '0';
--   signal ATCLKEN : std_logic := '0';
--   signal ATRESETn : std_logic := '0';
   signal ATDATA : std_logic_vector(7 downto 0) := (others => '0');
 --  signal ATID : std_logic_vector(6 downto 0) := (others => '0');
   signal ATVALID : std_logic := '0';
--   signal AFREADY : std_logic := '0';

 	--Outputs
   signal TRACESWO : std_logic;
   signal ATREADY : std_logic;
 --  signal AFVALID : std_logic;

   -- Clock period definitions
   constant TRACECLKIN_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SWO PORT MAP (
          CODR => CODR,
          SPPR => SPPR,
          TRACECLKIN => TRACECLKIN,
          TRESETn => TRESETn,
          TRACESWO => TRACESWO,
     --     ATCLK => ATCLK,
     --     ATCLKEN => ATCLKEN,
     --     ATRESETn => ATRESETn,
          ATDATA => ATDATA,
     --     ATID => ATID,
          ATVALID => ATVALID,
          ATREADY => ATREADY--,
     --     AFVALID => AFVALID,
     --     AFREADY => AFREADY
        );

   -- Clock process definitions
   ATCLK_process :process
   begin
		TRACECLKIN <= '1';
		wait for TRACECLKIN_period/2;
		TRACECLKIN <= '0';
		wait for TRACECLKIN_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ms.
		TRESETn	<= '1';
      wait for TRACECLKIN_period	* 10;
		TRESETn	<= '0';
     
	   loop
			wait for TRACECLKIN_period;
			if(ATREADY = '1') then
				ATDATA <= ATDATA + '1';	
				ATVALID <= '1';
			else
				ATVALID <= '0';
			end if;
		end loop;
	  

      -- insert stimulus here 

      wait;
   end process;

END;
