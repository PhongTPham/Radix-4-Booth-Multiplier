-- Company: Computer Architecture
-- Engineer: Christian Terrado
-- Create Date: 3/7/2020 
-- Design Name: 
-- Module Name: radix_booth - Behavioral 
-- Project Name: TeaFang Booth Radix-4
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


entity top_level is
    Port(clk:IN std_logic;
        reset:IN std_logic;
        LEDouts:OUT std_logic_vector(16 downto 0));

    attribute LOC:string;
    attribute LOC of clk: signal is "A10";
    attribute LOC of reset: signal is "N9";
    attribute LOC of LEDouts: signal is "L14 L16 K16 K15 J13 K14 J12 J11 J16 J14 D6 C6 F7 E6 A4 B5";

end top_level;

architecture Behavioral of top_level is

	--counts through the instructions
	Component ProgramCounter
		 port(clock:IN std_logic;
			  cease:IN std_logic; --Signals the program is over
			  reset:IN std_logic; --Resets the count to 0
			  PC:OUT std_logic_vector(30 downto 0));   --The current count
	End Component;

	--Contains the program
	Component InstructionMemory
		 port(PC:IN std_logic_vector(30 downto 0);   --The current count
			  Instruct:OUT std_logic_vector(3 downto 0)); --The current instruction
	End Component;

	--Sends out the appropriate control signals to execute the instruction
	Component ControlModule
		 port(Instruct:IN std_logic_vector(3 downto 0);
			  Rselect:IN std_logic_vector(2 downto 0); --Which registers go into add module
			  shftCtrl:OUT std_logic; --Which Direction does the shift occur
			  mathCtrl:OUT std_logic_vector(2 downto 0); --Which math module do register module's go to
			  writeCtrlReg:OUT std_logic_vector(2 downto 0); --Which register is writen to
			  writeCtrlIn:OUT std_logic_vector(2 downto 0); --selects write input either from registers or math module
			  Immediate:OUT std_logic_vector(30 downto 0);
			  Cease:OUT std_logic);
	End Component;

	Component RegisterMemory
		 port(clock:IN std_logic;
			  writeCtrlIn:IN std_logic_vector(2 downto 0);
			  writeCtrlReg:IN std_logic_vector(2 downto 0);
			  MathData:IN std_logic_vector(30 downto 0);
			  Immediate:IN std_logic_vector(30 downto 0);
			  Racc:OUT std_logic_vector(30 downto 0);
			  Radd: OUT std_logic_vector(30 downto 0);
			  Bplus:OUT std_logic_vector(30 downto 0));
	End Component;

	Component CheckModule
		 port(Racc:IN std_logic_vector(30 downto 0);
			  Rselect:OUT std_logic_vector(2 downto 0));
	End Component;

	Component AdderModule
		port(Radd: IN std_logic_vector(30 downto 0);
				Racc: IN std_logic_vector(30 downto 0);
				Aout: OUT std_logic_vector(30 downto 0));
	End Component;

	Component ShifterModule
		 port(Racc:IN std_logic_vector(30 downto 0);
			  shftCtrl:IN std_logic;
			  sout:OUT std_logic_vector(30 downto 0));
	End Component;

	Component InvertModule
		 port(Bplus:IN std_logic_vector(30 downto 0);
			  lout:OUT std_logic_vector(30 downto 0));
	End Component;

	Component DoubleModule
		port(Bplus: IN std_logic_vector(30 downto 0); -- B value
		 DBout: OUT std_logic_vector(30 downto 0));
	End Component;

	Component InvertDoubleModule
		port(Bplus: IN std_logic_vector(30 downto 0); 
		 DIout: OUT std_logic_vector(30 downto 0)); -- Output
	End Component;

	signal Racc, Radd, Bplus, Sout, Aout, Iout, DBout, DIout, MathData, immediate, PC:std_logic_vector(30 downto 0);
	signal writeCtrlReg,writeCtrlIn, Rselect, MathCtrl:std_logic_vector(2 downto 0);
	signal ShftCtrl, cease:std_logic;
	signal Instruct : std_logic_vector(3 downto 0);

begin

	Program:ProgramCounter Port Map(clk, cease, reset, PC);
	Instruction: InstructionMemory Port Map(PC, Instruct);
	Control:ControlModule Port Map(Instruct, Rselect, ShftCtrl, MathCtrl, WriteCtrlReg, writeCtrlIn, immediate, cease);
	Registers:RegisterMemory Port Map(clk, writeCtrlIn, writeCtrlReg, MathData, Immediate, Racc, Radd, Bplus);
	Check:CheckModule Port Map(Racc, Rselect);
	Adder:AdderModule Port Map(Radd, Racc, Aout);
	Shifter:ShifterModule Port Map(Racc, shftCtrl, Sout);
	Invert:InvertModule Port Map(Bplus, Iout);
	Double:DoubleModule Port Map(Bplus, DBout);
	InvetDouble:InvertDoubleModule Port Map(Bplus, DIout);

	process(mathCtrl, Sout, Aout, Iout, DBout, DIout)
	begin 
		 case mathCtrl is 
			  when "000" => MathData <= "0000000000000000000000000000000"; 
			  when "001" => MathData <= Sout; 
			  when "010" => MathData <= Aout; 
			  when "011" => MathData <= Iout;
			  when "100" => MathData <= DBout;
			  when others => MathData <= DIout;
		 end case; 
	end process; 


	-- Outputs the lower 17 bits of the accumulator on the LEDs 
	LEDouts <= Racc(16 downto 0); 

end Behavioral;
