----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/29/2016 09:57:57 PM
-- Design Name: 
-- Module Name: xadc_test - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

entity xadc_test is
    Port ( clk130   : in  STD_LOGIC;
           adc   : out STD_LOGIC_VECTOR (11 downto 0);
           vauxn14 : in  STD_LOGIC;
	   vauxp14 : in  STD_LOGIC
	   );
end xadc_test;

architecture Behavioral of xadc_test is
    signal reading : std_logic_vector(15 downto 0) := (others => '0');
    signal muxaddr : std_logic_vector( 4 downto 0) := (others => '0');
    signal channel : std_logic_vector( 4 downto 0) := (others => '0');
    signal vauxn   : std_logic_vector(15 downto 0) := (others => '0');
    signal vauxp   : std_logic_vector(15 downto 0) := (others => '0');

begin
    adc(0) <= reading(4);
    adc(1) <= reading(5);	
    adc(2) <= reading(6);
    adc(3) <= reading(7);
    adc(4) <= reading(8);
    adc(5) <= reading(9);
    adc(6) <= reading(10);
    adc(7) <= reading(11);
    adc(8) <= reading(12);
    adc(9) <= reading(13);
    adc(10) <= reading(14);     
    adc(11) <= reading(15);
    
    vauxp(14) <= vauxp14;  
    vauxn(14) <= vauxn14;
    
XADC_inst : XADC generic map (
      
      -- INIT_40 - INIT_42: XADC configuration registers
      INIT_40 => X"841E", -- config reg 0
      INIT_41 => X"310F", -- config reg 1
      INIT_42 => X"0400", -- config reg 2
      -- INIT_48 - INIT_4F: Sequence Registers
      INIT_48 => X"0100", -- Sequencer channel selection
      INIT_49 => X"0000", -- Sequencer channel selection
      INIT_4A => X"0000", -- Sequencer Average selection
      INIT_4B => X"0000", -- Sequencer Average selection
      INIT_4C => X"0000", -- Sequencer Bipolar selection
      INIT_4D => X"0000", -- Sequencer Bipolar selection
      INIT_4E => X"0000", -- Sequencer Acq time selection
      INIT_4F => X"0000", -- Sequencer Acq time selection
      -- INIT_50 - INIT_58, INIT5C: Alarm Limit Registers
      INIT_50 => X"B5ED", -- Temp alarm trigger
      INIT_51 => X"57E4", -- Vccint upper alarm limit
      INIT_52 => X"A147", -- Vccaux upper alarm limit
      INIT_53 => X"CA33",  -- Temp alarm OT upper
      INIT_54 => X"A93A", -- Temp alarm reset
      INIT_55 => X"52C6", -- Vccint lower alarm limit
      INIT_56 => X"9555", -- Vccaux lower alarm limit
      INIT_57 => X"AE4E",  -- Temp alarm OT reset
      INIT_58 => X"5999",  -- Vccbram upper alarm limit
      INIT_5C => X"5111",  -- Vccbram lower alarm limit
      INIT_59 => X"5555",  -- Vccpint upper alarm limit
      INIT_5D => X"5111",  -- Vccpint lower alarm limit
      INIT_5A => X"9999",  -- Vccpaux upper alarm limit
      INIT_5E => X"91EB",  -- Vccpaux lower alarm limit
      INIT_5B => X"6AAA",  -- Vccddro upper alarm limit
      INIT_5F => X"6666",  -- Vccddro lower alarm limit
      -- Simulation attributes: Set for proper simulation behavior
      SIM_DEVICE       => "ZYNQ",    -- Select target device (values)
      SIM_MONITOR_FILE => "design.txt"  -- Analog simulation data file name
   ) port map (
      -- ALARMS: 8-bit (each) output: ALM, OT
      ALM          => open,             -- 8-bit output: Output alarm for temp, Vccint, Vccaux and Vccbram
      OT           => open,             -- 1-bit output: Over-Temperature alarm

      -- STATUS: 1-bit (each) output: XADC status ports
      BUSY         => open,             -- 1-bit output: ADC busy output
      CHANNEL      => channel,          -- 5-bit output: Channel selection outputs
      EOC          => open,             -- 1-bit output: End of Conversion
      EOS          => open,             -- 1-bit output: End of Sequence
      JTAGBUSY     => open,             -- 1-bit output: JTAG DRP transaction in progress output
      JTAGLOCKED   => open,             -- 1-bit output: JTAG requested DRP port lock
      JTAGMODIFIED => open,             -- 1-bit output: JTAG Write to the DRP has occurred
      MUXADDR      => muxaddr,          -- 5-bit output: External MUX channel decode
      
      -- Auxiliary Analog-Input Pairs: 16-bit (each) input: VAUXP[15:0], VAUXN[15:0]
      VAUXN        => vauxn,            -- 16-bit input: N-side auxiliary analog input
      VAUXP        => vauxp,            -- 16-bit input: P-side auxiliary analog input
      
      -- CONTROL and CLOCK: 1-bit (each) input: Reset, conversion start and clock inputs
      CONVST       => '0',              -- 1-bit input: Convert start input
      CONVSTCLK    => '0',              -- 1-bit input: Convert start input
      RESET        => '0',              -- 1-bit input: Active-high reset
      
      -- Dedicated Analog Input Pair: 1-bit (each) input: VP/VN
      VN           => '0', -- 1-bit input: N-side analog input
      VP           => '0', -- 1-bit input: P-side analog input
      
      -- Dynamic Reconfiguration Port (DRP) -- hard set to read channel 6 (XADC4/XADC0)
      DO           => reading,
      DRDY         => open,
      DADDR        => "0011110",  -- The address for reading AUX channel 14
      DCLK         => clk130,
      DEN          => '1',
      DI           => (others => '0'),
      DWE          => '0'
   );
end Behavioral;
