import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taask/view/create_task/controller/create_task_cubit.dart';
import 'package:taask/view/create_task/controller/create_task_states.dart';
import 'package:taask/widgets/style.dart';

class CreateTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTaskCubit(),
      child: BlocConsumer<CreateTaskCubit,CreateTaskStates>(
        builder: (context, state) {
          var cubit = CreateTaskCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: w(context)*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new)),
                          const Spacer(),
                          MediaQuery.removePadding(
                              removeLeft: true,
                              context: context,
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.menu))),
                        ],
                      ),
                      Text("Create New Task",style: TextStyle(fontSize: AppFonts.h1,fontWeight: FontWeight.bold),),
                      SizedBox(height: h(context)*0.03,),
                      Text("Task Name",style: TextStyle(fontSize: AppFonts.t2,color: Colors.lightBlueAccent),),
                      TextFormField(),
                      SizedBox(height: h(context)*0.04,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Category",style: TextStyle(fontSize: AppFonts.t2,color: Colors.lightBlueAccent),),
                          InkWell(
                              onTap: (){},
                              child:Text("See all",style: TextStyle(fontSize: AppFonts.t3,color: Colors.lightBlueAccent),)
                          )
                        ],
                      ),
                      SizedBox(height: h(context)*0.02,),
                      SizedBox(
                        height: h(context)*0.05,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.title.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: EdgeInsets.symmetric(horizontal: w(context)*0.01),
                            child: InkWell(
                              onTap: (){
                                cubit.onSelected(index);
                              },
                              child: Container(
                                width: w(context)*0.3,
                                decoration: BoxDecoration(
                                    color: cubit.selectedIndex==index? Colors.blue : Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.blue)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(cubit.title[index],style: TextStyle(color:cubit.selectedIndex==index? Colors.white : Colors.blue),),
                                  ],),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h(context)*0.03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date",style: TextStyle(fontSize: AppFonts.t2,color: Colors.lightBlueAccent),),
                              SizedBox(
                                width: w(context)*0.7,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  controller: cubit.dateCtrl,
                                  readOnly: true,
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime(2101)).then((value) => cubit.selectDate(value));
                                  },
                                ),
                              ),
                            ],
                          ),
                          Image.asset("assets/images/calender.png",width: w(context)*0.1,)
                        ],
                      ),
                      SizedBox(height: h(context)*0.03,),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("Start time",style: TextStyle(color: Colors.lightBlueAccent),),
                              SizedBox(
                                width: w(context)*0.4,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  readOnly: true,
                                  controller: cubit.startCtrl,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.lightBlueAccent,)
                                  ),
                                  onTap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) =>
                                        cubit.selectStartTime('${value!.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}')
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text("End time",style: TextStyle(color: Colors.lightBlueAccent),),
                              SizedBox(
                                width: w(context)*0.4,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  readOnly: true,
                                  controller: cubit.endCtrl,
                                  decoration:const InputDecoration(
                                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded,color: Colors.lightBlueAccent,)
                                  ),
                                  onTap: (){
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now()
                                    ).then((value) =>
                                        cubit.selectEndTime('${value!.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}'));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: h(context)*0.03,),
                      Text("Description",style: TextStyle(fontSize: AppFonts.t2,color: Colors.lightBlueAccent),),
                      TextFormField(),
                      SizedBox(height: h(context)*0.04,),
                      Center(
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: w(context)*0.1,vertical: h(context)*0.015),
                            child: Text("Create Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: AppFonts.h2),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
}
