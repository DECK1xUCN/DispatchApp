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
    helicopter: Helicopter!
    pilot: Pilot!
    hoistOperator: HoistOperator!
  }
  # Input types
  input CreateDailyReportInput {
    date: DateTime!
    helicopterId: Int!
    pilotId: Int!
    hoistOperatorId: Int!
  }
  input UpdateDailyReportInput {
    date: DateTime
    helicopter: Int
    pilot: Int
    hoistOperator: Int
  }
`;

export default dailyReportTypeDefs;
