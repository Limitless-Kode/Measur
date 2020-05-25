class Project{
  String customerId;
  String dressmaker;
  String projectTitle;
  double totalCost;
  double amountPaid;
  DateTime startDate;
  DateTime endDate;
  //List<String> milestones;


  Project({
      this.dressmaker,
      this.customerId,
      this.projectTitle,
      this.totalCost,
      this.amountPaid,
      this.startDate,
      this.endDate,
      //this.milestones,
      });


  Map toMap(Project project){
    var data = Map<String, dynamic>();
    data["dressmaker"] = project.dressmaker;
    data["customer_id"] = project.customerId;
    data["project_title"] = project.projectTitle;
    data["total_cost"] = project.totalCost;
    data["amount_paid"] = project.amountPaid;
    data["start_date"] = project.startDate;
    data["end_date"] = project.endDate;

    return data;
  }


}