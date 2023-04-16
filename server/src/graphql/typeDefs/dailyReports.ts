import gql from "graphql-tag";

const dailyReportTypeDefs = gql`
  scalar DateTime

  type DailyReport {
    id: Int!
    date: DateTime!
    flights: [Flight!]!
  }

  type Query {
    dailyReportById(id: Int!): DailyReport!
    dailyReportsByDate(date: DateTime!): [DailyReport!]!
    dailyReports: [DailyReport!]!
  }
`;

export default dailyReportTypeDefs;
