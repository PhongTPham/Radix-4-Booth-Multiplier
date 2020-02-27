----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:50 02/19/2020 
-- Design Name: 
-- Module Name:    radix_booth - Behavioral 
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
        PC:OUT std_logic_vector(30 downto0));   --The current count
End Component;

--Contains the program
Component InstructionMemory
    port(PC:IN std_logic_vector(30 downto 0);   --The current count
        Instruct:OUT std_logic_vector(2 downto 0)); --The current instruction
End Component;

--Sends out the appropriate control signals to execute the instruction
component ControlMOdule
    port(Instruct:IN std_logic_vector(2 downto 0);
        Rselect:IN std_logic_vector(1 downto 0);
        shftCtrl:OUT std_logic;
        mathCtrl:OUT std_logic_vector(1 downto 0);
        writeCtrlReg:OUT std_logic_vector(1 downto 0);
        Immediate:OUT std_logic);
End Component

