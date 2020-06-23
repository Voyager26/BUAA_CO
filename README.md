P5-课上测试修改代码
----------------
## 主要增添指令：
### rotr 
Format:`rotr` `rd`,`rt`,`sa`<br>
s ← sa <br>
temp ← GPR[rt] s-1..0 || GPR[rt]31..s <br>
GPR[rd]← temp<br>
### clz
Format:`clz` `rd`,`rs`<br>
temp ← 32 <br>
for i in 31 .. 0<br>
&nbsp; if GPR[rs]i = 1 then<br>
&nbsp; &nbsp; temp ← 31 - i<br>
&nbsp; &nbsp; break<br>
&nbsp; endif <br>
endfor <br>
GPR[rd] ← temp<br>
### bgezal
Format:`rotr` `rs`,`offset`<br>
I:<br>
&nbsp; target_offset ← sign_extend(offset || 00 ) <br>
&nbsp; condition ← GPR[rs] ≥ 0 <br>
&nbsp; GPR[31] ← PC + 8<br>
I+1:   <br>
&nbsp; if condition then <br>
&nbsp; &nbsp; PC ← PC + target_offset <br>
&nbsp; endif
