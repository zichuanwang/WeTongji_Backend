# encoding: utf-8

worker_processes 10
timeout 30
 
root_path = File.expand_path '../', File.dirname(__FILE__)
working_directory root_path

# log
log_file = root_path + '/log/unicorn.log'
err_log  = root_path + '/log/unicorn_error.log'

stderr_path err_log
stdout_path log_file

# pid
pid_file = root_path + '/tmp/unicorn_wetongji_backend.pid'
old_pid = pid_file + '.oldbin'

pid pid_file

# socket
socket_file = root_path + '/tmp/unicorn_wetongji_backend.sock'

listen socket_file, backlog: 1024

preload_app true
 
# before_exec do |server|
#   ENV['BUNDLE_GEMFILE'] = root_path + '/Gemfile'
# end
 
before_fork do |server, worker|
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end
