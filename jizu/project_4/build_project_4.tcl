open_project "D:/shuziluoji/jizu/project_4/project_4.xpr"
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
set impl_status [get_property STATUS [get_runs impl_1]]
puts "IMPL_STATUS=$impl_status"
if {[string first "Complete" $impl_status] < 0} {
    exit 1
}
close_project
