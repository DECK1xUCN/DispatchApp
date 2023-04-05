import gql from "graphql-tag";

const dailyReportTypeDefs = gql`
  type Query {
    dailyReports: [DailyReport!]!
    dailyReport(id: Int!): DailyReport!
  }
  type Mutation {
    createDailyReport(data: CreateDailyReportInput): DailyReport!
    updateDailyReport(id: String!, data: UpdateDailyReportInput!): DailyReport!
  }
  type DailyReport {
    id: Int!
    date: DateTime!
    pilot: Pilot!
    hoist: HoistOperator!
  }
  # Input types
  input CreateDailyReportInput {
    date: DateTime!
    pilotId: Int!
    hoistOperatorId: Int!
  }
  input UpdateDailyReportInput {
    date: DateTime
    pilot: Int
    hoistOperator: Int
  }
`;

export default dailyReportTypeDefs;
