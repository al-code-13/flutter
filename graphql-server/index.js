const express = require("express");
const app = express();

const express_graphql = require("express-graphql");
const { buildSchema } = require("graphql");

//data
const { courses } = require("./data.json");
console.log(courses);

const schema = buildSchema(`
    type Query{
        course(id:Int!): Course
        courses(topic: String):[Course]
    }
    type Course{
        id: Int
        title: String
        description: String
        author: String
        topic: String
        url: String
    }

`);

let getCourse = (arg) => {
  let id = arg.id;
  return courses.filter((course) => {
    return course.id == id;
  })[0];
};
let getCourses = (arg) => {
  if (arg.topic) {
    let topic = arg.topic;
    return courses.filter((course) => course.topic == topic);
  }else{
      return courses;
  }
};
const root = {
  course: getCourse,
  courses: getCourses,
};

app.use(
  "/graphql",
  express_graphql({
    schema: schema,
    rootValue: root,
    graphiql: true,
  })
);

app.listen(3000, () => console.log("server run in port 3000"));
