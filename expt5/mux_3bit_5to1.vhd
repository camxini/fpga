library ieee;
use ieee.std_logic_1164.all;

entity mux_3bit_5to1 is
	port(
	s, u, v, w, x, y : in std_logic_vector(2 downto 0);
	m : out std_logic_vector(2 downto 0));
end mux_3bit_5to1;

architecture behavior of mux_3bit_5to1 is
begin
	process(s, u, v, w, x, y)
	begin
		if s = "000" then
			m <= u;
		elsif s = "001" then
            m <= v;
        elsif s = "010" then
            m <= w;
        elsif s = "011" then
            m <= x;
        elsif s = "100" then
            m <= y;
        else
			m <= "000";
		end if;
	end process;
end behavior;