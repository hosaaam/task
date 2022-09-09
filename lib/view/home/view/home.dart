import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taask/view/home/controller/home_cubit.dart';
import 'package:taask/view/home/controller/home_state.dart';
import 'package:taask/widgets/style.dart';
import 'package:taask/widgets/widgets.dart';

import '../../create_task/view/view.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =HomeCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.blueAccent[100],
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: w(context)*0.02,vertical: h(context)*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/boy.jpg"),
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.menu,)),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_sharp)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("My Task",style: TextStyle(fontSize: AppFonts.h1+10,fontWeight: FontWeight.w900),),
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              navigateTo(context, CreateTaskScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.all(h(context)*0.015),
                              decoration:const  BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Icon(Icons.add,color: Colors.white,size: w(context)*0.08),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: h(context)*0.02,),
                      Row(
                        children: [
                          Text("Today",style: TextStyle(fontSize: AppFonts.t1,fontWeight: FontWeight.bold),),
                          const Spacer(),
                          Text("Monday, 1 June",style: TextStyle(fontSize: AppFonts.t3),),
                        ],
                      ),
                      SizedBox(
                        height: h(context)*0.1,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.days.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: EdgeInsets.symmetric(horizontal: w(context)*0.01),
                            child: InkWell(
                              onTap: (){
                                cubit.onSelected(index);
                              },
                              child: Container(
                                width: w(context)*0.2,
                                height: h(context)*0.1,
                                decoration:  BoxDecoration(
                                    color:
                                    cubit.selectedIndex==index? Colors.blue:Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.blue,width: 2)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(cubit.days[index],style: TextStyle(color: cubit.selectedIndex==index? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,fontSize: AppFonts.t1),),
                                    Text(cubit.title[index],style: TextStyle(color: cubit.selectedIndex==index? Colors.white : Colors.black,fontSize: AppFonts.t1)),
                                  ],),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: h(context)*0.05,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.subTitle.length,
                        itemBuilder: (context,index)=>SizedBox(
                          height: h(context)*0.17,
                          width: w(context)*0.5,
                          child: Stack(
                            children: [
                              Container(
                                height: h(context)*0.15,
                                width: w(context)*0.94,
                                padding: EdgeInsets.symmetric(horizontal: w(context)*0.03,vertical: h(context)*0.02),
                                decoration:  BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:  BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                  border: Border.all(color: Colors.blue)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(cubit.taskImage[index],width: w(context)*0.2),
                                    const Spacer(),
                                    SizedBox(
                                      width: w(context)*0.5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cubit.taskName[index],style: TextStyle(fontSize: AppFonts.h2),),
                                          Text(cubit.subTitle[index],style: TextStyle(fontSize: AppFonts.t3),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration:const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Colors.black
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: w(context)*0.02,vertical: h(context)*0.01),
                                  child: Text(cubit.taskTime[index],style: TextStyle(fontSize: AppFonts.t1,color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: h(context)*0.02,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
