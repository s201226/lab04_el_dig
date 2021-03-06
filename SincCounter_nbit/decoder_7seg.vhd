library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_7seg is
	port(num:in unsigned(3 downto 0);
		to_hex:out std_logic_vector(0 to 6));
end decoder_7seg;


architecture behavioral of decoder_7seg is
begin
	process(num)
	begin
		case num is
			when "0000"=>to_hex<="0000001";
			when "0001"=>to_hex<="1001111";
			when "0010"=>to_hex<="0010010";
			when "0011"=>to_hex<="0000110"; 
			when "0100"=>to_hex<="1001100";
			when "0101"=>to_hex<="0100100";
			when "0110"=>to_hex<="0100000";
			when "0111"=>to_hex<="0001111";
			when "1000"=>to_hex<="0000000";
			when "1001"=>to_hex<="0000100";
			when "1010"=>to_hex<="0001000";
			when "1011"=>to_hex<="1100000";
			when "1100"=>to_hex<="0110001";
			when "1101"=>to_hex<="1000010";
			when "1110"=>to_hex<="0110000";
			when "1111"=>to_hex<="0111001";
			when others=>to_hex<="0000000";
		end case;
	end process;
end behavioral;
			