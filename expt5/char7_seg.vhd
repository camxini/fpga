library ieee;
use ieee.std_logic_1164.all;

entity char_7seg is 
	port(
		c : in std_logic_vector(2 downto 0);
		display : out std_logic_vector(0 to 6));
end char_7seg;

architecture behavior of char_7seg is
begin
	process(c)
	begin
		if c = "000" then
			display <= "0001001";
		elsif c = "001" then
			display <= "0000110";
		elsif c = "010" then
			display <= "1000111";
		elsif c = "011" then
			display <= "1000000";
		elsif c = "100" then
			display <= "1111111";
		else
			display <= "1111111";
		end if;
	end process;
end behavior;