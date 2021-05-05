#!/usr/bin/env ruby

def display_list()
   if(File.file?("todo.txt"))
      file_data = File.read("todo.txt").split("\n")
      cnt = file_data.length
      if(cnt > 0)
         cnt.times {
           cnt == 1 ? (print"[#{cnt}] #{file_data[cnt-1]}") : (puts"[#{cnt}] #{file_data[cnt-1]}")
           cnt -= 1
         }
      else
         puts'There are no pending todos!'
      end
   else
       puts'There are no pending todos!'
   end
end

def add_to_file(add_val)
  wt = File.new("todo.txt","a")
  wt.puts(add_val)
  wt.close
  print'Added todo: "',add_val,'"'
end

def delete_line(line_num,opt)
  if line_num.to_i.to_s == line_num
     line_num = line_num.to_i
     file_data = File.read("todo.txt").split("\n")
     if(line_num > 0 && line_num <= file_data.length)
       file_data.delete_at(line_num-1)
       wrt = File.new("todo.txt","w")
       file_data.each do |i|
          wrt.puts(i)
       end
       wrt.close
       print"Deleted todo ##{line_num}" if opt
     else
        print"Error: todo ##{line_num} does not exist. Nothing deleted."
     end
  else
     puts line_num
     puts"Error: It is not an integer"
  end
end

def mark_as_done(data_index)
   file_data = File.read("todo.txt").split("\n")
   if data_index.to_i.to_s == data_index
      data_index = data_index.to_i
      file_data = File.read("todo.txt").split("\n")
      if data_index > 0 && data_index <= file_data.length
         wt = File.new("done.txt","a")
         wt.puts("x #{Time.now.strftime("%Y-%m-%d")} #{file_data[data_index-1]}")
         wt.close
         delete_line(data_index.to_s,false)
         print"Marked todo ##{data_index} as done."
      else
         print"Error: todo ##{data_index} does not exist."
      end
   else
      puts"Error: It is not an integer"
   end
end

main_arg = ARGV
if(main_arg[0] == "help" || main_arg[0].nil?)
   puts 'Usage :-
$ ./todo add "todo item"  # Add a new todo
$ ./todo ls               # Show remaining todos
$ ./todo del NUMBER       # Delete a todo
$ ./todo done NUMBER      # Complete a todo
$ ./todo help             # Show usage
$ ./todo report           # Statistics'.strip;
elsif(main_arg[0] == "add")
   main_arg[1].nil? ? (print"Error: Missing todo string. Nothing added!") : (add_to_file(main_arg[1]))
elsif(main_arg[0] == "ls")
   display_list()
elsif(main_arg[0] == "del")
   if main_arg[1].nil?
      print"Error: Missing NUMBER for deleting todo."
   else
      delete_line(main_arg[1],true)
   end
elsif(main_arg[0] == "done")
    main_arg[1].nil? ? (print"Error: Missing NUMBER for marking todo as done.") : (mark_as_done(main_arg[1]))
elsif(main_arg[0] == "report")
   print"#{Time.now.strftime("%Y-%m-%d")} Pending : #{File.read("todo.txt").split("\n").length} Completed : #{File.read("done.txt").split("\n").length}"
else
   print"Invalid command"
end