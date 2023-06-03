/*Find all the topics and tasks taught in the month of October:*/
db.topics.aggregate([
  {
    $match: {
      date: {
        $gte: ISODate("2020-10-01"),
        $lt: ISODate("2020-11-01")
      }
    }
  },
  {
    $lookup: {
      from: "tasks",
      localField: "_id",
      foreignField: "topic_id",
      as: "tasks"
    }
  }
])


/*Find all the company drives that appeared between 15th October 2020 and 31st October 2020:*/
db.company_drives.find({
  date: {
    $gte: ISODate("2020-10-15"),
    $lte: ISODate("2020-10-31")
  }
})


/*Find all the company drives and students who appeared for the placement:*/
db.company_drives.aggregate([
  {
    $lookup: {
      from: "attendance",
      localField: "_id",
      foreignField: "user_id",
      as: "students"
    }
  }
])


/*Find the number of problems solved by the user in CodeKata:*/
db.codekata.aggregate([
  {
    $match: {
      user_id: <user_id>
    }
  },
  {
    $group: {
      _id: "$user_id",
      problems_solved: { $sum: { $cond: { if: "$solved", then: 1, else: 0 } } }
    }
  }
])


/*Find all the mentors who have more than 15 mentees:*/
db.mentors.find({
  mentee_count: { $gt: 15 }
})


/*Find the number of users who were absent and task not submitted between 15th October 2020 and 31st October 2020:*/
db.attendance.aggregate([
  {
    $lookup: {
      from: "tasks",
      localField: "user_id",
      foreignField: "user_id",
      as: "user_tasks"
    }
  },
  {
    $match: {
      date: {
        $gte: ISODate("2020-10-15"),
        $lte: ISODate("2020-10-31")
      },
      status: "absent",
      "user_tasks.submitted": false
    }
  },
  {
    $count: "count"
  }
])

