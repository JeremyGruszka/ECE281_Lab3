----------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: Silva
-- 
-- Create Date:    12:43:25 07/07/2012 
-- Module Name:    Nexys2_Lab3top - Behavioral 
-- Target Devices: Nexys2 Project Board
-- Tool versions: 
-- Description: This file is a shell for implementing designs on a NEXYS 2 board
-- 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys2_top_shell is
    Port ( 	clk_50m : in STD_LOGIC;
				btn : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
				switch : in STD_LOGIC_VECTOR (7 DOWNTO 0);
				SSEG_AN : out STD_LOGIC_VECTOR (3 DOWNTO 0);
				SSEG : out STD_LOGIC_VECTOR (7 DOWNTO 0);
				LED : out STD_LOGIC_VECTOR (7 DOWNTO 0));
end Nexys2_top_shell;

architecture Behavioral of Nexys2_top_shell is

---------------------------------------------------------------------------------------
--This component converts a nibble to a value that can be viewed on a 7-segment display
--Similar in function to a 7448 BCD to 7-seg decoder
--Inputs: 4-bit vector called "nibble"
--Outputs: 8-bit vector "sseg" used for driving a single 7-segment display
---------------------------------------------------------------------------------------
	COMPONENT nibble_to_sseg
	PORT(
		nibble : IN std_logic_vector(3 downto 0);          
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

---------------------------------------------------------------------------------------------
--This component manages the logic for displaying values on the NEXYS 2 7-segment displays
--Inputs: system clock, synchronous reset, 4 8-bit vectors from 4 instances of nibble_to_sseg
--Outputs: 7-segment display select signal (4-bit) called "sel", 
--         8-bit signal called "sseg" containing 7-segment data routed off-chip
---------------------------------------------------------------------------------------------
	COMPONENT nexys2_sseg
	GENERIC ( CLOCK_IN_HZ : integer );
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		sseg0 : IN std_logic_vector(7 downto 0);
		sseg1 : IN std_logic_vector(7 downto 0);
		sseg2 : IN std_logic_vector(7 downto 0);
		sseg3 : IN std_logic_vector(7 downto 0);          
		sel : OUT std_logic_vector(3 downto 0);
		sseg : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--This component divides the system clock into a bunch of slower clock speeds
--Input: system clock 
--Output: 27-bit clockbus. Reference module for the relative clock speeds of each bit
--			 assuming system clock is 50MHz
-------------------------------------------------------------------------------------
	COMPONENT Clock_Divider
	PORT(
		clk : IN std_logic;          
		clockbus : OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;

-------------------------------------------------------------------------------------
--Below are declarations for signals that wire-up this top-level module.
-------------------------------------------------------------------------------------

signal nibble0, nibble1, nibble2, nibble3 : std_logic_vector(3 downto 0);
signal sseg0_sig, sseg1_sig, sseg2_sig, sseg3_sig : std_logic_vector(7 downto 0);
signal ClockBus_sig : STD_LOGIC_VECTOR (26 downto 0);


--------------------------------------------------------------------------------------
--Insert your design's component declaration below	
--------------------------------------------------------------------------------------

--moore elevator component
--Component MooreElevatorController_Shell
--    Port ( clk : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           stop : in  STD_LOGIC;
--           up_down : in  STD_LOGIC;
--			  
------------------------------------------------------------------------------
----this one used for the prime number elevator
--			  --floorMo : out  STD_LOGIC_VECTOR (7 downto 0));
--			  
------------------------------------------------------------------------------
----this one used for the regular moore elevator
--			  --floorMo : out std_logic_vector ( 3 downto 0));
--end component;

--------------------------------------------------------------------------------------

--mealy elevator component
--COMPONENT MealyElevatorController_Shell
--	PORT(
--		clk : IN std_logic;
--		reset : IN std_logic;
--		stop : IN std_logic;
--		up_down : IN std_logic;          
--		floorMe : OUT std_logic_vector(3 downto 0);
--		nextfloorMe : OUT std_logic_vector(3 downto 0)
--		);
--	END COMPONENT;
	
--------------------------------------------------------------------------------------

--change input component
--COMPONENT MooreElevatorChooseInputs
--	PORT(
--		clk : IN std_logic;
--		reset : IN std_logic;
--		stop : IN std_logic;
--		up_down : IN std_logic_vector(7 downto 0);          
--		floorMc : OUT std_logic_vector(7 downto 0)
--		);
--	END COMPONENT;

--------------------------------------------------------------------------------------
--Insert any required signal declarations below
--------------------------------------------------------------------------------------

--this line is for moore elevator(both regular and prime numbers
	--Signal clk, reset, stop, up_down : Std_logic;
	
--------------------------------------------------------------------------------------

--this line is for the mealy elevator
	--Signal floorMe, nextfloorMe : std_logic_vector(3 downto 0);
	
--------------------------------------------------------------------------------------

--these lines are for the two moores(first is prime numbers, second is regular)
	--Signal floorMo : std_logic_vector(7 downto 0);
	--Signal floorMo : std_logic_vector(3 downto 0);
	
--------------------------------------------------------------------------------------
--these lines are for the change input elevator
	--Signal floorMc, up_down : std_logic_vector (7 downto 0);
	--Signal clk, reset, stop : Std_logic;


begin

----------------------------
--code below tests the LEDs:
----------------------------

--the following process makes the LEDs go to the left if the elevator is going up, and 
--to the right if the elevator is going down
process (Switch(7)) is
	begin
		if Switch(7) = '1' then
			LED(0) <= CLOCKBUS_SIG(19);
			LED(1) <= CLOCKBUS_SIG(20);
			LED(2) <= CLOCKBUS_SIG(21);
			LED(3) <= CLOCKBUS_SIG(22);
			LED(4) <= CLOCKBUS_SIG(23);
			LED(5) <= CLOCKBUS_SIG(24);
			LED(6) <= CLOCKBUS_SIG(25);
			LED(7) <= CLOCKBUS_SIG(26);
		else
			LED(0) <= CLOCKBUS_SIG(26);
			LED(1) <= CLOCKBUS_SIG(25);
			LED(2) <= CLOCKBUS_SIG(24);
			LED(3) <= CLOCKBUS_SIG(23);
			LED(4) <= CLOCKBUS_SIG(22);
			LED(5) <= CLOCKBUS_SIG(21);
			LED(6) <= CLOCKBUS_SIG(20);
			LED(7) <= CLOCKBUS_SIG(19);
		end if;
	end process;

--------------------------------------------------------------------------------------------	
--This code instantiates the Clock Divider. Reference the Clock Divider Module for more info
--------------------------------------------------------------------------------------------
	Clock_Divider_Label: Clock_Divider PORT MAP(
		clk => clk_50m,
		clockbus => ClockBus_sig
	);

--------------------------------------------------------------------------------------	
--Code below drives the function of the 7-segment displays. 
--Function: To display a value on 7-segment display #0, set the signal "nibble0" to 
--				the value you wish to display
--				To display a value on 7-segment display #1, set the signal "nibble1" to 
--				the value you wish to display...and so on
--Note: You must set each "nibble" signal to a value. 
--		  Example: if you are not using 7-seg display #3 set nibble3 to "0000"
--------------------------------------------------------------------------------------

--uncomment the following two nibbles for prime numbers
--nibble0 <= "0010" when (floorMo = "00000001") else
--			"0011" when (floorMo = "00000010") else
--			"0101" when (floorMo = "00000011") else
--			"0111" when (floorMo = "00000100") else
--			"0001" when (floorMo = "00000101") else
--			"0011" when (floorMo = "00000110") else
--       "0111" when (floorMo = "00000111") else
--			"1001" when (floorMo = "00001000");
--nibble1 <= "0000" when (floorMo = "00000001") else
--			"0000" when (floorMo = "00000010") else
--			"0000" when (floorMo = "00000011") else
--			"0000" when (floorMo = "00000100") else
--			"0001";
--

--------------------------------------------------------------------------------------

--uncomment the following two nibbles for regular moore 4 floor elevator
--nibble0 <= "0001" when (floorMo = "0001") else
--			"0010" when (floorMo = "0010") else
--			"0011" when (floorMo = "0011") else
--			"0100" when (floorMo = "0100");
--nibble1 <= "0000";

--------------------------------------------------------------------------------------

--uncomment the following two nibbles for regular mealy 4 floor elevator
--nibble0 <= "0001" when (floorMe = "0001") else
--			"0010" when (floorMe = "0010") else
--			"0011" when (floorMe = "0011") else
--			"0100";
--nibble1 <= "0001" when (nextfloorMe = "0001") else
--			"0010" when (nextfloorMe = "0010") else
--			"0011" when (nextfloorMe = "0011") else
--			"0100" when (nextfloorMe = "0100");

--------------------------------------------------------------------------------------

--uncomment the following two nibbles for change inputs
--nibble0 <= "0000" when (floorMc = "00000000") else
--			"0001" when (floorMc = "00000001") else
--			"0010" when (floorMc = "00000010") else
--			"0011" when (floorMc = "00000011") else
--			"0100" when (floorMc = "00000100") else
--			"0101" when (floorMc = "00000101") else
--         "0110" when (floorMc = "00000110") else
--			"0111" when (floorMc = "00000111");
--nibble1 <= "0000";


--------------------------------------------------------------------------------------

nibble2 <= "0000";
nibble3 <= "0000";
--This code converts a nibble to a value that can be displayed on 7-segment display #0
	sseg0: nibble_to_sseg PORT MAP(
		nibble => nibble0,
		sseg => sseg0_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #1
	sseg1: nibble_to_sseg PORT MAP(
		nibble => nibble1,
		sseg => sseg1_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #2
	sseg2: nibble_to_sseg PORT MAP(
		nibble => nibble2,
		sseg => sseg2_sig
	);

--This code converts a nibble to a value that can be displayed on 7-segment display #3
	sseg3: nibble_to_sseg PORT MAP(
		nibble => nibble3,
		sseg => sseg3_sig
	);
	
--This module is responsible for managing the 7-segment displays, you don't need to do anything here
	nexys2_sseg_label: nexys2_sseg 
	generic map ( CLOCK_IN_HZ => 50E6 )
	PORT MAP(
		clk => clk_50m,
		reset => '0',
		sseg0 => sseg0_sig,
		sseg1 => sseg1_sig,
		sseg2 => sseg2_sig,
		sseg3 => sseg3_sig,
		sel => SSEG_AN,
		sseg => SSEG
	);

-----------------------------------------------------------------------------
--Instantiate the design you with to implement below and start wiring it up!:
-----------------------------------------------------------------------------

--uncomment this instantiatino for moore elevator(regular and prime numbers)

--Inst_MooreElevatorController_Shell: MooreElevatorController_Shell PORT MAP(
--		clk => ClockBus_sig(25),
--		reset => switch(0),
--		stop => switch(6),
--		up_down => switch(7),
--		floorMo => floorMo
--	);

--------------------------------------------------------------------------------------

--uncomment this instantiation for mealy elevator
--Inst_MealyElevatorController_Shell: MealyElevatorController_Shell PORT MAP(
--		clk => ClockBus_sig(25),
--		reset => switch(0),
--		stop => switch(6),
--		up_down => switch(7),
--		floorMe => floorMe,
--		nextfloorMe => nextfloorMe
--	);
	
--------------------------------------------------------------------------------------

--uncomment this instantiation for moore elevator with changable inputs

--Inst_MooreElevatorChooseInputs: MooreElevatorChooseInputs PORT MAP(
--		clk => ClockBus_sig(25),
--		reset => btn(0),
--		stop => btn(1),
--		up_down => switch,
--		floorMc => floorMc
--	);

end Behavioral;
