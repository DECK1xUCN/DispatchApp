import gql from "graphql-tag";

const dailyUpdatesTypeDefs = gql`
  type Query {
    dailyUpdates: [DailyUpdate!]!
    dailyUpdate(id: Int!): DailyUpdate!
  }
  type Mutation {
    createDailyUpdate(data: DailyUpdateInput): DailyUpdate!
    updateDailyUpdate(id: String!, data: DailyUpdateInput!): DailyUpdate!
  }
  type DailyUpdate {
    id: Int!
    flight: Flight!
    date: DateTime!
    wasFlight: Boolean!
    delay: Boolean!
    delayReason: String!
    delayReasonDesc: String!
    maintenace: Boolean!
    plannedMaintenance: Boolean!
    unplannedMaintenance: Boolean!
    otherMaintenance: Boolean!
    maintenanceDesc: String!
    baseAndEquipment: Boolean!
    note: String!
  }
  # Input types
  input DailyUpdateInput {
    flight: Int!
    date: DateTime!
    wasFlight: Boolean!
    delay: Boolean!
    delayReason: String
    delayReasonDesc: String
    maintenace: Boolean!
    plannedMaintenance: Boolean
    unplannedMaintenance: Boolean
    otherMaintenance: Boolean
    maintenanceDesc: String
    baseAndEquipment: Boolean!
    note: String
  }
`;

export default dailyUpdatesTypeDefs;
