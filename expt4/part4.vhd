library ieee;
use ieee.std_logic_1164.all;

entity part4 is
	port(
		c2, c1, c0 : in std_logic;
		hex0 : out std_logic_vector(6 downto 0));
end part4;

architecture behavior of part4 is
begin
	hex0(0) <= not c0 or c2;
	hex0(1) <= (c0 xor c1) or c2;
	hex0(2) <= (c0 xor c1) or c2;
	hex0(3) <= not(c0 or c1) or c2;
	hex0(4) <= c2;
	hex0(5) <= c2;
	hex0(6) <= c1 or c2;
end behavior;