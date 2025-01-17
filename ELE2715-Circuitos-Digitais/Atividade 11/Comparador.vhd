entity Comparador is
  port (in_gt, in_eq, in_lt,a,b: in bit;
        out_eq,out_lt,out_gt: out bit);
end Comparador;

architecture ckt of Comparador is
  begin
    out_gt <= in_gt OR (in_eq AND a AND (NOT b));
    out_lt <= in_lt OR (in_eq AND (NOT a) AND b);
    out_eq <= in_eq AND (a XNOR b);
end ckt; 