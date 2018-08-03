proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/rd/vivado-outputs/XADC_3_DEM/XADC.cache/wt [current_project]
  set_property parent.project_path /home/rd/vivado-outputs/XADC_3_DEM/XADC.xpr [current_project]
  set_property ip_repo_paths {
  /home/rd/vivado-outputs/XADC_3_DEM/XADC.cache/ip
  /home/rd/zybo-audio/ac_interface
  /home/rd/vivado-outputs/ShiftSlice
  /home/rd/vivado-outputs/lcd16x2
  /home/rd/vivado-outputs/delayz1z2
  /home/rd/vivado-outputs/switch_out2n
  /home/rd/vivado-outputs/IP
  /home/rd/vivado-outputs/IP_VGA_VL
} [current_project]
  set_property ip_output_repo /home/rd/vivado-outputs/XADC_3_DEM/XADC.cache/ip [current_project]
  add_files -quiet /home/rd/vivado-outputs/XADC_3_DEM/XADC.runs/synth_1/System_wrapper.dcp
  read_xdc -ref System_processing_system7_0_0 -cells inst /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_processing_system7_0_0/System_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_processing_system7_0_0/System_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref System_rst_processing_system7_0_100M_0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_rst_processing_system7_0_100M_0/System_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_rst_processing_system7_0_100M_0/System_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref System_rst_processing_system7_0_100M_0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_rst_processing_system7_0_100M_0/System_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_rst_processing_system7_0_100M_0/System_rst_processing_system7_0_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_0_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_0_0/System_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_0_0/System_axi_gpio_0_0_board.xdc]
  read_xdc -ref System_axi_gpio_0_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_0_0/System_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_0_0/System_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_1_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_1_0/System_axi_gpio_1_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_1_0/System_axi_gpio_1_0_board.xdc]
  read_xdc -ref System_axi_gpio_1_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_1_0/System_axi_gpio_1_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_1_0/System_axi_gpio_1_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_3_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_3_0/System_axi_gpio_3_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_3_0/System_axi_gpio_3_0_board.xdc]
  read_xdc -ref System_axi_gpio_3_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_3_0/System_axi_gpio_3_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_3_0/System_axi_gpio_3_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_2_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_2_0/System_axi_gpio_2_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_2_0/System_axi_gpio_2_0_board.xdc]
  read_xdc -ref System_axi_gpio_2_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_2_0/System_axi_gpio_2_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_2_0/System_axi_gpio_2_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_4_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_4_0/System_axi_gpio_4_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_4_0/System_axi_gpio_4_0_board.xdc]
  read_xdc -ref System_axi_gpio_4_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_4_0/System_axi_gpio_4_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_4_0/System_axi_gpio_4_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_5_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_5_0/System_axi_gpio_5_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_5_0/System_axi_gpio_5_0_board.xdc]
  read_xdc -ref System_axi_gpio_5_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_5_0/System_axi_gpio_5_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_5_0/System_axi_gpio_5_0.xdc]
  read_xdc -ref System_xadc_channel_14_0_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/ipshared/TD/xadc_ch14_bipol_v1_3/92a3b9cb/constrs_1/imports/Vivado/ZYBO_Master.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/ipshared/TD/xadc_ch14_bipol_v1_3/92a3b9cb/constrs_1/imports/Vivado/ZYBO_Master.xdc]
  read_xdc -prop_thru_buffers -ref System_clk_wiz_0_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_clk_wiz_0_0/System_clk_wiz_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_clk_wiz_0_0/System_clk_wiz_0_0_board.xdc]
  read_xdc -ref System_clk_wiz_0_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_clk_wiz_0_0/System_clk_wiz_0_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_clk_wiz_0_0/System_clk_wiz_0_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_6_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_6_0/System_axi_gpio_6_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_6_0/System_axi_gpio_6_0_board.xdc]
  read_xdc -ref System_axi_gpio_6_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_6_0/System_axi_gpio_6_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_6_0/System_axi_gpio_6_0.xdc]
  read_xdc -prop_thru_buffers -ref System_axi_gpio_7_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_7_0/System_axi_gpio_7_0_board.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_7_0/System_axi_gpio_7_0_board.xdc]
  read_xdc -ref System_axi_gpio_7_0 -cells U0 /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_7_0/System_axi_gpio_7_0.xdc
  set_property processing_order EARLY [get_files /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/sources_1/bd/System/ip/System_axi_gpio_7_0/System_axi_gpio_7_0.xdc]
  read_xdc /home/rd/vivado-outputs/XADC_3_DEM/XADC.srcs/constrs_1/new/System.xdc
  link_design -top System_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force System_wrapper_opt.dcp
  catch {report_drc -file System_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force System_wrapper_placed.dcp
  catch { report_io -file System_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file System_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file System_wrapper_utilization_placed.rpt -pb System_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file System_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force System_wrapper_routed.dcp
  catch { report_drc -file System_wrapper_drc_routed.rpt -pb System_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file System_wrapper_timing_summary_routed.rpt -rpx System_wrapper_timing_summary_routed.rpx }
  catch { report_power -file System_wrapper_power_routed.rpt -pb System_wrapper_power_summary_routed.pb }
  catch { report_route_status -file System_wrapper_route_status.rpt -pb System_wrapper_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force System_wrapper.bit 
  if { [file exists /home/rd/vivado-outputs/XADC_3_DEM/XADC.runs/synth_1/System_wrapper.hwdef] } {
    catch { write_sysdef -hwdef /home/rd/vivado-outputs/XADC_3_DEM/XADC.runs/synth_1/System_wrapper.hwdef -bitfile System_wrapper.bit -meminfo System_wrapper.mmi -file System_wrapper.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

