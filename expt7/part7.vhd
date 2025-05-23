library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part7 is
    port ( 
        clk : in std_logic;
        reset : in std_logic;
        roll : in std_logic;
        seg1 : out std_logic_vector(6 downto 0);
        seg2 : out std_logic_vector(6 downto 0);
        win : out std_logic;
        lose : out std_logic
    );
end part7;

architecture behavioral of part7 is
    signal point : integer; -- used to save the sum of two dices
    type state_type is (idle, rolling, other_check, win_state, lose_state);
    signal state : state_type := idle;
    signal counter2_wrap : std_logic := '0'; -- flag to indicate counter2 has wrapped
    signal prev_roll : std_logic := '0'; -- previous roll value
    signal first_check_done : std_logic := '0'; -- flag to judge first check or other checks
    

    -- function used to transfer binary number to hex
    function bin_to_hex(bin: unsigned(3 downto 0)) return std_logic_vector is
        variable hex: std_logic_vector(6 downto 0);
    begin
        case bin is
            when "0001" => hex := "1111001"; -- 1
            when "0010" => hex := "0100100"; -- 2
            when "0011" => hex := "0110000"; -- 3
            when "0100" => hex := "0011001"; -- 4
            when "0101" => hex := "0010010"; -- 5
            when "0110" => hex := "0000010"; -- 6
            when others => hex := "1111111";
        end case;
        return hex;
    end function;

begin

process(clk, reset)
    variable counter1 : unsigned(3 downto 0) := "0001";
    variable counter2 : unsigned(3 downto 0) := "0001";
    variable counter1_save : unsigned(3 downto 0) := "0001"; -- save value of counter1 when game over
    variable counter2_save : unsigned(3 downto 0) := "0001"; -- save value of counter2 when game over
    variable finish : std_logic := '0';
begin
    if reset = '1' then
        counter1 := "0001";
        counter2 := "0001";
        counter1_save := "0001";
        counter2_save := "0001";
        counter2_wrap <= '0';
        state <= idle;
        prev_roll <= '0';
        first_check_done <= '0';
        win <= '0';
        lose <= '0';
        seg1 <= bin_to_hex("0001");
        seg2 <= bin_to_hex("0001");
        finish := '0';

    elsif rising_edge(clk) then
        -- update the previous roll state
        prev_roll <= roll;

        case state is
            when idle =>
                if roll = '1' and finish = '0' then
                    state <= rolling;
                elsif finish = '1' then
					seg1 <= bin_to_hex(counter1_save);
					seg2 <= bin_to_hex(counter2_save);
                end if;

            when rolling =>
				-- counter1 and counter2 rotation
                if roll = '1' then
                    if to_integer(counter2) < 5 then
                        counter2 := counter2 + 1;
                        counter2_wrap <= '0';
                    elsif to_integer(counter2) = 5 then
                        counter2 := counter2 + 1;
                        counter2_wrap <= '1';
                    else
                        counter2 := "0001";
                        counter2_wrap <= '0';
                    end if;

                    if counter2_wrap = '1' then
                        counter1 := counter1 + 1;
                        counter2_wrap <= '0';
                        if to_integer(counter1) > 5 then
                            counter1 := "0001";
                        end if;
                    end if;

                    -- hex display
                    seg1 <= bin_to_hex(counter1);
                    seg2 <= bin_to_hex(counter2);
                end if;

                -- when falling edge of roll, start judgement
                if roll = '0' and prev_roll = '1' then
					-- first check
                    if first_check_done = '0' then
                        if to_integer(counter1) + to_integer(counter2) = 7 or 
                           to_integer(counter1) + to_integer(counter2) = 11 then
                            state <= win_state;
                        elsif to_integer(counter1) + to_integer(counter2) = 2 or 
                              to_integer(counter1) + to_integer(counter2) = 3 or 
                              to_integer(counter1) + to_integer(counter2) = 12 then
                            state <= lose_state;
                        else
                            point <= to_integer(counter1) + to_integer(counter2);
                            state <= other_check;
                            first_check_done <= '1';
                        end if;
                    -- other checks
                    elsif first_check_done = '1' then
                        if to_integer(counter1) + to_integer(counter2) = point then
                            state <= win_state;
                        elsif to_integer(counter1) + to_integer(counter2) = 7 then
                            state <= lose_state;
                        else
                            state <= other_check;
                        end if;
                    end if;
                end if;

            when other_check =>
                seg1 <= bin_to_hex(counter1);
                seg2 <= bin_to_hex(counter2);

                if roll = '1' then
                    state <= rolling;
                end if;

            when win_state =>
                win <= '1';
                state <= idle;
                first_check_done <= '0';
                finish := '1';
                counter1_save := counter1;
				counter2_save := counter2;

            when lose_state =>
                lose <= '1';
                state <= idle;
                first_check_done <= '0';
                finish := '1';
                counter1_save := counter1;
				counter2_save := counter2;
        end case;
    end if;
end process;

end behavioral;