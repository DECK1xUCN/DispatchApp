import gql from "graphql-tag";

const dailyReportTypeDefs = gql`
  scalar DateTime

  type DailyReport {
    id: Int!
    date: DateTime!
    flights: [Flight!]!
  }

  type Query {
    dailyReportsById(id: Int!): DailyReport!
    dailyReportByDate(date: DateTime!): [DailyReport!]!
    dailyReports(date: DateTime, id: Int): [DailyReport!]!
  }
  type Mutation {
    createDailyReports: Boolean!
  }
`;

export default dailyReportTypeDefs;
