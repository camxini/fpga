library ieee;
use ieee.std_logic_1164.all;

entity part2 is
	port(
		s : in std_logic;
		x : in std_logic_vector(7 downto 0);
		y : in std_logic_vector(7 downto 0);
		ledg : out std_logic_vector(7 downto 0);
		ledr : out std_logic_vector(17 downto 0));
end part2;

architecture behavior of part2 is
begin
	ledg(0) <= (not(s) and x(0)) or (s and y(0));
	ledg(1) <= (not(s) and x(1)) or (s and y(1));
	ledg(2) <= (not(s) and x(2)) or (s and y(2));
	ledg(3) <= (not(s) and x(3)) or (s and y(3));
	ledg(4) <= (not(s) and x(4)) or (s and y(4));
	ledg(5) <= (not(s) and x(5)) or (s and y(5));
	ledg(6) <= (not(s) and x(6)) or (s and y(6));
	ledg(7) <= (not(s) and x(7)) or (s and y(7));
	ledr(0) <= x(0);
	ledr(1) <= x(1);
	ledr(2) <= x(2);
	ledr(3) <= x(3);
	ledr(4) <= x(4);
	ledr(5) <= x(5);
	ledr(6) <= x(6);
	ledr(7) <= x(7);
	ledr(8) <= y(0);
	ledr(9) <= y(1);
	ledr(10) <= y(2);
	ledr(11) <= y(3);
	ledr(12) <= y(4);
	ledr(13) <= y(5);
	ledr(14) <= y(6);
	ledr(15) <= y(7);
	ledr(17) <= s;
end behavior;