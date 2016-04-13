library ieee;
use ieee.std_logic_1164.all;

entity LatchSR is
	port(Clk,S,R:in std_logic;
		Q:out std_logic);
end LatchSR;

architecture structural of LatchSR is
	signal R_g,S_g,Qa,Qb: std_logic;
	attribute keep: boolean;
	attribute keep of R_g,S_g,Qa,Qb:signal is true;
begin
	R_g<=R and Clk;
	S_g<=S and Clk;
	Qa<=not(R_g or Qb);
	Qb<=not(S_g or Qa);
	Q<=Qa;
end structural;