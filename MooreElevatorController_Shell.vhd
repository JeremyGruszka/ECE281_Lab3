-- Company: USAFA/DFEC
-- Engineer: Silva
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		CE3
-- Module Name:    	MooreElevatorController_Shell - Behavioral 
-- Description: 		Shell for completing CE3
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

entity MooreElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
			  
----------------------------------------------------------------------------
--this one used for the prime number elevator
			  --floorMo : out  STD_LOGIC_VECTOR (7 downto 0));
			  
----------------------------------------------------------------------------
--this one used for the regular moore elevator
			  --floorMo : out std_logic_vector ( 3 downto 0));
end MooreElevatorController_Shell;

architecture Behavioral of MooreElevatorController_Shell is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic

---------------------------------------------------------------------------- 
--this one used for the prime number elevator
--  type floor_state_type is (floor1, floor2, floor3, floor4, floor5, floor6, floor7, floor8);

----------------------------------------------------------------------------
--this one used for the regular moore elevator
--type floor_state_type is (floor1, floor2, floor3, floor4);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
begin
	--clk'event and clk='1' is VHDL-speak for a rising edge
	if clk'event and clk='1' then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		if reset='1' then
			floor_state <= floor1;
		--now we will code our next-state logic
		else
			case floor_state is
				--when our current state is floor1
				when floor1 =>
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						--floor2 right?? This makes sense!
						floor_state <= floor2;
					--otherwise we're going to stay at floor1
					else
						floor_state <= floor1;
					end if;
				--when our current state is floor2
				when floor2 => 
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
					--otherwise we're going to stay at floor2
					else
						floor_state <= floor2;
					end if;
					
					--when our current state is floor3
				when floor3 => 
					--if up_down is set to "go up" and stop is set to 
					--"don't stop" which floor do we want to go to?
					if (up_down='1' and stop='0') then 
						floor_state <= floor4; 			
					--if up_down is set to "go down" and stop is set to 
					--"don't stop" which floor do we want to go to?
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;
					--otherwise we're going to stay at floor2
					else
						floor_state <= floor3;
					end if;
					
					
				when floor4 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else 
						floor_state <= floor4;
					end if;
					
----------------------------------------------------------------------------
--following commented section is for the prime number elevator
					
--					--when our current state is floor4
--				when floor4 => 
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor5; 			
--					--if up_down is set to "go down" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor3;
--					--otherwise we're going to stay at floor2
--					else
--						floor_state <= floor4;
--					end if;
--					
--					--when our current state is floor5
--				when floor5 => 
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor6; 			
--					--if up_down is set to "go down" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor4;
--					--otherwise we're going to stay at floor2
--					else
--						floor_state <= floor5;
--					end if;
--					
--					--when our current state is floor6
--				when floor6 => 
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor7; 			
--					--if up_down is set to "go down" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor5;
--					--otherwise we're going to stay at floor2
--					else
--						floor_state <= floor6;
--					end if;
--					
--					--when our current state is floor7
--				when floor7 => 
--					--if up_down is set to "go up" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					if (up_down='1' and stop='0') then 
--						floor_state <= floor8; 			
--					--if up_down is set to "go down" and stop is set to 
--					--"don't stop" which floor do we want to go to?
--					elsif (up_down='0' and stop='0') then 
--						floor_state <= floor6;
--					--otherwise we're going to stay at floor2
--					else
--						floor_state <= floor7;
--					end if;
--				
--				--floor8
--				when floor8 =>
--					if (up_down='0' and stop='0') then 
--						floor_state <= floor7;	
--					else 
--						floor_state <= floor8;
--					end if;
				
				--This line accounts for phantom states
				when others =>
					floor_state <= floor1;
			end case;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below


----------------------------------------------------------------------------
--this one is for the prime number elevator
--floorMo <= "00000001" when (floor_state = floor1) else
--			"00000010" when (floor_state = floor2) else
--			"00000011" when (floor_state = floor3) else
--			"00000100" when (floor_state = floor4) else
--			"00000101" when (floor_state = floor5) else
--			"00000110" when (floor_state = floor6) else
--			"00000111" when (floor_state = floor7) else
--			"00001000" when (floor_state = floor8) ;

----------------------------------------------------------------------------
--this one is for the regular moore elevator
--floorMo <= "0001" when (floor_state = floor1) else
--			 "0010" when (floor_state = floor2) else
--			 "0011" when (floor_state = floor3) else
--			 "0100" when (floor_state = floor4);

end Behavioral;

