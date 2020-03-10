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
    attribute LOC of clk: signal is "P89";
    attribute LOC of reset: signal is "P15";
    attribute LOC of LEDouts: signal is "P32 P33 P34 P35 P36 P60 P40 P41 P47 P48 P49 P 58 P98 P95 P94 P92 P91";

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
component ControlMOdule
    port(Instruct:IN std_logic_vector(3 downto 0);
        Rselect:IN std_logic_vector(2 downto 0); --Which registers go into add module
        shftCtrl:OUT std_logic; --Which Direction does the shift occur
        mathCtrl:OUT std_logic_vector(2 downto 0); --Which math module do register module's go to
        writeCtrlReg:OUT std_logic_vector(2 downto 0); --Which register is writen to
        -- TODO: figure out how many write inputs we need to read from
        writeCtrlIn:OUT std_logic_vector(2 downto 0); --selects write input either from registers or math module
        Immediate:OUT std_logic;
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
    port(Racc:IN std_logic_vector(30 down to 0);
        Rselect:OUT std_logic_vector(1 downto 0));
Add(01 +B,10 -B,00 0)
End Component;

Component ShifterModule
    port(Racc:IN std_logic_vector(30 downto 0);
        shftCtrl:IN std_logic;
        sout:OUT std_logic_vector(30 downto 0));
End Component;

Component InvertModule
    port(Bplus:IN std_logic_vector(30 downto 0);
        Iout:OUT std_logic_vector(30 downto 0));
End Component;

signal Racc, Radd, Bplus, Sout, Aout, Iout, MathData, immediate, PC:std_logic_vector(30 downto 0);
signal writeCtrlREg, Rselect, MathCtrl:std_logic_vector(1 downto 0);
signal ShftCtrl, cease:std_logic;

begin

Program:ProgramCounter Port Map(clk, cease, reset, PC);
Instruction: InstructionMemory Port Map(PC, Instruct);
Control:ControlModule Port Map(Instruct, Rselect, ShftCtrl, MathCtrl, WriteCtrlReg, writeCtrlIn, Immediate, cease);
Registers:RegisterMemory Port Map(clk, writeCtrlIn, writeCtrlReg, MathData, Immediate, Racc, Radd, Bplus);
Check:CheckModule Port Map(Racc, Rselect);
Adder:AdderModule Port Map(Radd, Racc, Aout);
Shifter:ShifterModule Port Map(Racc, shftCtrl, Sout);
Invert:InvertModule Port Map(Bplus, Iout);

process(mathCtrl, Sout, Aout, Iout)
begin 
    case mathCtrl is 
        when "000" => MathData <= "0000000000000000000000000000000"; 
        when "001" => MathData <= Sout; 
        when "010" => MathData <= Aout; 
        when "011" => MathData <= Iout;
        when "100" => MathData <= Dout;
        when "others" => MathData <= DIout;
    end case; 
end process; 


-- Outputs the lower 17 bits of the accumulator on the LEDs 
LEDouts <= Racc(16 downto 0); 

end Behavioral;
