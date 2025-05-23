library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part5 is
	port(
		sw : in std_logic_vector(17 downto 0);
		hex0, hex1, hex2, hex3, hex4 : out std_logic_vector(0 to 6));
end part5;

architecture behavior of part5 is
	component mux_3bit_5to1
		port(
			s, u, v, w, x, y : in std_logic_vector(2 downto 0);
			m : out std_logic_vector(2 downto 0));
	end component;
	
	component char_7seg
		port(
			c : in std_logic_vector(2 downto 0);
			display : out std_logic_vector(6 downto 0));
	end component;
	
	signal m0, m1, m2, m3, m4 : std_logic_vector(2 downto 0);
	signal s_plus_0, s_plus_1, s_plus_2, s_plus_3, s_plus_4 : std_logic_vector(2 downto 0);
	
	begin
		process(sw)
				variable temp : unsigned(2 downto 0);
			begin
				--temp := to_unsigned(to_integer(unsigned(sw(17 downto 15))), 4) mod 5;
				--s_plus_0 <= std_logic_vector(temp(2 downto 0));

				--temp := to_unsigned(to_integer(unsigned(sw(17 downto 15))) + 1, 4) mod 5;
				--s_plus_1 <= std_logic_vector(temp(2 downto 0));

				--temp := to_unsigned(to_integer(unsigned(sw(17 downto 15))) + 2, 4) mod 5;
				--s_plus_2 <= std_logic_vector(temp(2 downto 0));

				--temp := to_unsigned(to_integer(unsigned(sw(17 downto 15))) + 3, 4) mod 5;
				--s_plus_3 <= std_logic_vector(temp(2 downto 0));

				--temp := to_unsigned(to_integer(unsigned(sw(17 downto 15))) + 4, 4) mod 5;
				--s_plus_4 <= std_logic_vector(temp(2 downto 0));
				temp := unsigned(sw(17 downto 15)) mod 5;
				s_plus_0 <= std_logic_vector(temp(2 downto 0));

				temp := (unsigned(sw(17 downto 15)) + 1) mod 5;
				s_plus_1 <= std_logic_vector(temp(2 downto 0));

				temp := (unsigned(sw(17 downto 15)) + 2) mod 5;
				s_plus_2 <= std_logic_vector(temp(2 downto 0));

				temp := (unsigned(sw(17 downto 15)) + 3) mod 5;
				s_plus_3 <= std_logic_vector(temp(2 downto 0));

				temp := (unsigned(sw(17 downto 15)) + 4) mod 5;
				s_plus_4 <= std_logic_vector(temp(2 downto 0));
			end process;
		
		mux0 : mux_3bit_5to1 port map(
			s_plus_0, sw(14 downto 12), sw(11 downto 9),
			sw(8 downto 6), sw(5 downto 3), sw(2 downto 0), m0);
		mux1 : mux_3bit_5to1 port map(
			s_plus_1, sw(14 downto 12), sw(11 downto 9),
			sw(8 downto 6), sw(5 downto 3), sw(2 downto 0), m1);
		mux2 : mux_3bit_5to1 port map(
			s_plus_2, sw(14 downto 12), sw(11 downto 9),
			sw(8 downto 6), sw(5 downto 3), sw(2 downto 0), m2);
		mux3 : mux_3bit_5to1 port map(
			s_plus_3, sw(14 downto 12), sw(11 downto 9),
			sw(8 downto 6), sw(5 downto 3), sw(2 downto 0), m3);
		mux4 : mux_3bit_5to1 port map(
			s_plus_4, sw(14 downto 12), sw(11 downto 9),
			sw(8 downto 6), sw(5 downto 3), sw(2 downto 0), m4);
			
		h4 : char_7seg port map(m0, hex4);
		h3 : char_7seg port map(m1, hex3);
		h2 : char_7seg port map(m2, hex2);
		h1 : char_7seg port map(m3, hex1);
		h0 : char_7seg port map(m4, hex0);
end behavior;