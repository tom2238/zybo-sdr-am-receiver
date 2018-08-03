----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2017 08:42:24 PM
-- Design Name: 
-- Module Name: delayz - Behavioral
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

entity delayz is
    generic	(
		D_WIDTH: INTEGER:=12 			
		);  
	port (
		aclkFs: in STD_LOGIC;
		data_in :in STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);		 
		data_out_1 :out STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);
		data_out_2 :out STD_LOGIC_VECTOR (D_WIDTH-1 downto 0)
		);
end delayz;

architecture Behavioral of delayz is
    signal		last_sm1:  STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);     
	signal		last_sm2:  STD_LOGIC_VECTOR (D_WIDTH-1 downto 0);   
begin

    process (aclkFs)
	begin
		if (rising_edge(aclkFs)) then
			last_sm1 <= data_in;
			last_sm2 <= last_sm1;
		end if;
	end process;
	
	data_out_1 <= last_sm1;
	data_out_2 <= last_sm2;
end Behavioral;
