library ieee;
use ieee.std_logic_1164.all;

entity part3 is
	port(
		s2, s1, s0 : in std_logic;
		u, v, w, x, y : in std_logic_vector(2 downto 0);
		ledr : out std_logic_vector(17 downto 0);
		m : out std_logic_vector(2 downto 0));

end part3;

architecture behavior of part3 is
begin
	ledr(0) <= u(0);
	ledr(1) <= u(1);
	ledr(2) <= u(2);
	ledr(3) <= v(0);
	ledr(4) <= v(1);
	ledr(5) <= v(2);
	ledr(6) <= w(0);
	ledr(7) <= w(1);
	ledr(8) <= w(2);
	ledr(9) <= x(0);
	ledr(10) <= x(1);
	ledr(11) <= x(2);
	ledr(12) <= y(0);
	ledr(13) <= y(1);
	ledr(14) <= y(2);
	ledr(15) <= s0;
	ledr(16) <= s1;
	ledr(17) <= s2;
	
	process(u, v, w, x, y)
	begin
		if s2 = '1' then
			m <= y;
		elsif s2 = '0' and s0 = '0' and s1 = '0' then
			m <= u;
		elsif s2 = '0' and s0 = '0' and s1 = '1' then
			m <= w;
		elsif s2 = '0' and s0 = '1' and s1 = '0' then
			m <= v;
		elsif s2 = '0' and s0 = '1' and s1 = '1' then
			m <= x;
		else
			m <= "000";
		end if;
	end process;
end behavior;