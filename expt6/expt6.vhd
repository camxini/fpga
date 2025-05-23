library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity expt6 is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable_in : in STD_LOGIC;  -- 输入信号 enable(0)
        q : out STD_LOGIC_VECTOR(15 downto 0);
        hex0, hex1, hex2, hex3 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end expt6;

architecture behavior of expt6 is
    signal internal_q : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  -- 内部状态寄存器
    signal enable : STD_LOGIC_VECTOR(15 downto 0);  -- 计算后的 enable 信号
    signal hex_value : STD_LOGIC_VECTOR(15 downto 0);
begin
    -- 计算 enable(1) 到 enable(3)
    enable(0) <= enable_in;
    enable(1) <= enable(0) and internal_q(0);
    enable(2) <= enable(1) and internal_q(1);
    enable(3) <= enable(2) and internal_q(2);
    enable(4) <= enable(3) and internal_q(3);
    enable(5) <= enable(4) and internal_q(4);
    enable(6) <= enable(5) and internal_q(5);
    enable(7) <= enable(6) and internal_q(6);
    enable(8) <= enable(7) and internal_q(7);
    enable(9) <= enable(8) and internal_q(8);
    enable(10) <= enable(9) and internal_q(9);
    enable(11) <= enable(10) and internal_q(10);
    enable(12) <= enable(11) and internal_q(11);
    enable(13) <= enable(12) and internal_q(12);
    enable(14) <= enable(13) and internal_q(13);
    enable(15) <= enable(14) and internal_q(14);

    process(clk, reset)
    begin
        if reset = '1' then
            -- 重置所有 q 信号
            internal_q <= (others => '0');
        elsif rising_edge(clk) then
            -- 更新 q 信号
            for i in 0 to 3 loop
                if enable(i) = '1' then
                    internal_q(i) <= not internal_q(i);  -- T触发器的翻转行为
                end if;
            end loop;
        end if;
    end process;

    -- 将内部状态寄存器赋值给输出 q
    q <= internal_q;
    
    hex_value <= internal_q(15 downto 0);
    
    process(hex_value)
	begin
        case hex_value(3 downto 0) is
            when "0000" => hex0(6 downto 0) <= "1000000";  -- 0
            when "0001" => hex0(6 downto 0) <= "1111001";  -- 1
            when "0010" => hex0(6 downto 0) <= "0100100";  -- 2
            when "0011" => hex0(6 downto 0) <= "0110000";  -- 3
            when "0100" => hex0(6 downto 0) <= "0011001";  -- 4
            when "0101" => hex0(6 downto 0) <= "0010010";  -- 5
            when "0110" => hex0(6 downto 0) <= "0000010";  -- 6
            when "0111" => hex0(6 downto 0) <= "1111000";  -- 7
            when "1000" => hex0(6 downto 0) <= "0000000";  -- 8
            when "1001" => hex0(6 downto 0) <= "0010000";  -- 9
            when "1010" => hex0(6 downto 0) <= "0001000";  -- A
            when "1011" => hex0(6 downto 0) <= "0000011";  -- B
            when "1100" => hex0(6 downto 0) <= "1000110";  -- C
            when "1101" => hex0(6 downto 0) <= "0100001";  -- D
            when "1110" => hex0(6 downto 0) <= "0000110";  -- E
            when "1111" => hex0(6 downto 0) <= "0001110";  -- F
            when others => hex0(6 downto 0) <= "1111111";  -- 空
        end case;

        case hex_value(7 downto 4) is
            when "0000" => hex1(6 downto 0) <= "1000000";  -- 0
            when "0001" => hex1(6 downto 0) <= "1111001";  -- 1
            when "0010" => hex1(6 downto 0) <= "0100100";  -- 2
            when "0011" => hex1(6 downto 0) <= "0110000";  -- 3
            when "0100" => hex1(6 downto 0) <= "0011001";  -- 4
            when "0101" => hex1(6 downto 0) <= "0010010";  -- 5
            when "0110" => hex1(6 downto 0) <= "0000010";  -- 6
            when "0111" => hex1(6 downto 0) <= "1111000";  -- 7
            when "1000" => hex1(6 downto 0) <= "0000000";  -- 8
            when "1001" => hex1(6 downto 0) <= "0010000";  -- 9
            when "1010" => hex1(6 downto 0) <= "0001000";  -- A
            when "1011" => hex1(6 downto 0) <= "0000011";  -- B
            when "1100" => hex1(6 downto 0) <= "1000110";  -- C
            when "1101" => hex1(6 downto 0) <= "0100001";  -- D
            when "1110" => hex1(6 downto 0) <= "0000110";  -- E
            when "1111" => hex1(6 downto 0) <= "0001110";  -- F
            when others => hex1(6 downto 0) <= "1111111";  -- 空
        end case;

        case hex_value(11 downto 8) is
            when "0000" => hex2(6 downto 0) <= "1000000";  -- 0
            when "0001" => hex2(6 downto 0) <= "1111001";  -- 1
            when "0010" => hex2(6 downto 0) <= "0100100";  -- 2
            when "0011" => hex2(6 downto 0) <= "0110000";  -- 3
            when "0100" => hex2(6 downto 0) <= "0011001";  -- 4
            when "0101" => hex2(6 downto 0) <= "0010010";  -- 5
            when "0110" => hex2(6 downto 0) <= "0000010";  -- 6
            when "0111" => hex2(6 downto 0) <= "1111000";  -- 7
            when "1000" => hex2(6 downto 0) <= "0000000";  -- 8
            when "1001" => hex2(6 downto 0) <= "0010000";  -- 9
            when "1010" => hex2(6 downto 0) <= "0001000";  -- A
            when "1011" => hex2(6 downto 0) <= "0000011";  -- B
            when "1100" => hex2(6 downto 0) <= "1000110";  -- C
            when "1101" => hex2(6 downto 0) <= "0100001";  -- D
            when "1110" => hex2(6 downto 0) <= "0000110";  -- E
            when "1111" => hex2(6 downto 0) <= "0001110";  -- F
            when others => hex2(6 downto 0) <= "1111111";  -- 空
        end case;

        case hex_value(15 downto 12) is
            when "0000" => hex3(6 downto 0) <= "1000000";  -- 0
            when "0001" => hex3(6 downto 0) <= "1111001";  -- 1
            when "0010" => hex3(6 downto 0) <= "0100100";  -- 2
            when "0011" => hex3(6 downto 0) <= "0110000";  -- 3
            when "0100" => hex3(6 downto 0) <= "0011001";  -- 4
            when "0101" => hex3(6 downto 0) <= "0010010";  -- 5
            when "0110" => hex3(6 downto 0) <= "0000010";  -- 6
            when "0111" => hex3(6 downto 0) <= "1111000";  -- 7
            when "1000" => hex3(6 downto 0) <= "0000000";  -- 8
            when "1001" => hex3(6 downto 0) <= "0010000";  -- 9
            when "1010" => hex3(6 downto 0) <= "0001000";  -- A
            when "1011" => hex3(6 downto 0) <= "0000011";  -- B
            when "1100" => hex3(6 downto 0) <= "1000110";  -- C
            when "1101" => hex3(6 downto 0) <= "0100001";  -- D
            when "1110" => hex3(6 downto 0) <= "0000110";  -- E
            when "1111" => hex3(6 downto 0) <= "0001110";  -- F
            when others => hex3(6 downto 0) <= "1111111";  -- 空
        end case;
    end process;
end behavior;