----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2017 08:47:48 PM
-- Design Name: 
-- Module Name: switch_port - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity switch_port is
    generic	(
		D_WIDTH: INTEGER:=12 			
		); 
    Port ( aclk : in STD_LOGIC;
           control : in STD_LOGIC;
           data_in1 : in STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);
           data_in2 : in STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (D_WIDTH-1 downto 0)
           );
end switch_port;

architecture Behavioral of switch_port is

begin
    process(aclk)
    begin
    if (rising_edge(aclk)) then
        if (control = '0') then
            data_out <= data_in1;
        elsif (control = '1') then
            data_out <= data_in2;   
        end if;        
    end if;
    end process;

end Behavioral;
