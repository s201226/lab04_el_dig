library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coder_7seg is
	port(hex:in std_logic_vector(0 to 6);
		num:out unsigned(3 downto 0));
end coder_7seg;


architecture behavior of coder_7seg is
begin
	process(hex)
		begin
		case hex is
			when "0000001"=>num<="0000";
			when "1001111"=>num<="0001";
			when "0010010"=>num<="0010";
			when "0000110"=>num<="0011";
			when "1001100"=>num<="0100";
			when "0100100"=>num<="0101";
			when "0100000"=>num<="0110";
			when "0001111"=>num<="0111";
			when "0000000"=>num<="1000";
			when "0000100"=>num<="1001";
			when "0001000"=>num<="1010";
			when "1100000"=>num<="1011";
			when "0110001"=>num<="1100";
			when "1000010"=>num<="1101";
			when "0110000"=>num<="1110";
			when "0111000"=>num<="1111";
			when others=>num<="0000";
		end case;
	end process;
end architecture;