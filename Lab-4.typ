#import "Class.typ": *


#show: ieee.with(
  title: [#text(smallcaps("Lab #4: ROS2 using RCLPY in Julia"))],
  /*
  abstract: [
    #lorem(10).
  ],
  */
  authors:
  (
    (
      name: "Abdelbacet Mhamdi",
      department: [Senior-lecturer, Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "a-mhamdi",
    ),

    
    (
      name: "Namouchi Skander",
      department: [Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "Iskander000",
    ),
    /*
    (
      name: "Student 2",
      department: [Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "abc",
    ),
    (
      name: "Student 3",
      department: [Dept. of EE],
      organization: [ISET Bizerte --- Tunisia],
      profile: "abc",
    )
  */

  )
  // index-terms: (""),
  // bibliography-file: "Biblio.bib",
)
 
You are required to carry out this lab using the REPL as in @fig:repl.

#figure(
	image("Images/REPL.png", width: 100%, fit: "contain"),
	caption: "Julia REPL"
	) <fig:repl>
=== instructions :

We begin first of all by sourcing our ROS2 installation as follows:
```zsh
source /opt/ros/humble/setup.zsh
```
- then we need to open the subscriber and the publisher programmes in two different terminal 
#let publisher=read("../Codes/ros2/publisher.jl")
#let subscriber=read("../Codes/ros2/subscriber.jl")

#raw(publisher, lang: "julia")
#footnote[Remember to source ROS2 installation before using it with Julia]

#raw(subscriber, lang: "julia")

- In a newly opened terminal, the exucation will show to us that the subscriber  listens to the messages being broadcasted by our previous publisher and respond by a massage 
to do that we need first of all to create a nodes called subscriber and publisher 
```julia 
# Create publisher node
node = rclpy.create_node("my_publisher")
rclpy.spin_once(node, timeout_sec=1)
# Create subscriber  node
node = rclpy.create_node("my_subscriber")
```
 to link the two talker and the heard to a specific topic like here we choose *infodev* as a topic like showing the graph 

```julia 
pub = node.create_publisher(str.String, "infodev", 10)

# Create a ROS2 subscription
sub = node.create_subscription(str.String, "infodev", callback, 10)
```
- The graphical tool *rqt_graph* of @fig:rqt_graph displays the flow of data between our nodes: #emph[my_publisher] and #emph[my_subscriber], through the topic we designed _infodev_

#figure(
	image("Images/rqt_graph.png", width: 100%),
	caption: "rqt_graph"
) <fig:rqt_graph>



- after linked publisher / subscriber together and then to a specifique topic the execution terminal will show us what in fig 3
#figure(
	image("Images/pub-sub.png", width: 100%),
	caption: "Minimal publisher/subscriber in ROS2",
) <fig:pub-sub>
- to change the message or the number of the messages prodcasted or respondet we can use this line 
```julia
# Publish the message `txt`
for i in range(1, 100)
    msg = str.String(data="Hello, ROS2 from Julia! ($(string(i)))")
    pub.publish(msg)
    txt = "[TALKER] " * msg.data 
    @info txt
    sleep(1)
end
# Callback function to process received messages
function callback(msg)
    txt = "[LISTENER] I heard: " * msg.data
    @info txt
end

```
- if you haad a problem in the topic wich one you shoul use you can check from the topic list by right down this line

```zsh
source /opt/ros/humble/setup.zsh
ros2 topic list -t
```

@fig:topic-list shows the current active topics, along their corresponding interfaces.



#figure(
	image("Images/topic-list.png", width: 100%),
	caption: "List of topics",
) <fig:topic-list>

//#test[Some test]

