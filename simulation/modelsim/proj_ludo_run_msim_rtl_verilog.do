transcript on
if ![file isdirectory proj_ludo_iputf_libs] {
	file mkdir proj_ludo_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "E:/Personal_Project/FPGA_UART/sampler_sim/sampler.vo"

vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/vga_driver.sv}
vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/top.sv}
vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/i2cinput.sv}
vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/i2c_master.sv}
vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/clock_divider.sv}
vlog -sv -work work +incdir+E:/Personal_Project/FPGA_UART/verilog {E:/Personal_Project/FPGA_UART/verilog/byte2ledhex.sv}

