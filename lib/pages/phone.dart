import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference phone = FirebaseFirestore.instance.collection("phone");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(onTap:(){Get.back();}, child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 22,)),
        title: Text("Phones",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
        actions: [
          Icon(Icons.search,color: Colors.black,size: 24,),
          Gap(15),
          Icon(Icons.shopping_cart,color: Colors.black,size: 22,),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_to_home_screen),
                    Gap(4),
                    Text("Compare",style: TextStyle(fontSize: 16),),
                  ],
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Icon(Icons.sort),
                    Gap(4),
                    Text("Sort",style: TextStyle(fontSize: 16),),
                  ],
                ),
                Container(
                  height: 40,
                  width: 2,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Icon(Icons.filter_list_alt),
                    Gap(4),
                    Text("Filter",style: TextStyle(fontSize: 16),),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
            Gap(20),
            Padding(
              padding: const EdgeInsets.all(5.1),
              child: StreamBuilder<QuerySnapshot>(
                stream: phone.snapshots(),
                builder: (context,snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final pho = snapshot.requireData;
                  return ListView.builder(
                      itemCount: pho.size,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                        final phone = pho.docs[index];
                        return Column(
                          children: [
                            Container(
                                height: 400,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 230,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image: NetworkImage("${phone['image']}"),fit: BoxFit.cover)
                                            ),
                                           ),
                                        Gap(10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.5,
                                              child: Text("${phone['name']}",style: TextStyle(fontSize: 19),maxLines: 2,),
                                            ),
                                            Gap(10),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.black
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("${phone['rating']}",style: TextStyle(color: Colors.white),),
                                                      Icon(Icons.star,color: Colors.white,size: 20,),
                                                    ],
                                                  ),
                                                ),
                                                Gap(6),
                                                Text("(30)",style: TextStyle(color: Colors.grey,fontSize: 15),),
                                              ],
                                            ),
                                            Gap(15),
                                            Row(
                                              children: [
                                                Text(
                                                  "\$ ${phone['payment']}",
                                                  style:TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Gap(6),
                                                Text(
                                                  "\$ ${phone['pay']}",
                                                  style:TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey,
                                                    decoration:
                                                    TextDecoration.lineThrough,
                                                  ),
                                                ),
                                                Gap(5),
                                                Text(
                                                  "${phone['discount']}",
                                                  style:TextStyle(
                                                      fontSize: 19,
                                                      color: Colors.green,fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(15),
                                            Row(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.discount,size: 20,),
                                                Gap(6),
                                                Container(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    child: Text("Upto \$1300 off on Exchange products")),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Gap(10),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          height: 45,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          child: Text("${phone['explain1']}"),
                                        ),
                                        Gap(10),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          height: 45,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          child: Text("${phone['explain2']}"),
                                        ),
                                      ],
                                    ),
                                    Gap(10),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      height: 40,
                                      width: 350,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      child: Text("${phone['explain3']}"),
                                    ),
                                    Gap(30),
                                    Divider()
                                  ],
                                )),
                          ],
                        );
                        });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
