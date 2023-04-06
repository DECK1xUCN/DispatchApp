import gql from "graphql-tag";

const dailyUpdatesTypeDefs = gql`
  type Query {
    dailyUpdates: [DailyUpdate!]!
    dailyUpdate(id: Int!): DailyUpdate!
  }
  type Mutation {
    createDailyUpdate(data: CreateDailyUpdateInput): DailyUpdate!
    updateDailyUpdate(id: String!, data: UpdateDailyUpdateInput!): DailyUpdate!
  }
  type DailyUpdate {
    id: Int!
    flight: Flight!
    date: DateTime!
    wasFlight: Boolean!
    delay: Boolean!
    delayReason: String!
    delayDesc: String!
    maintenace: Boolean!
    plannedMaintenance: Boolean!
    unplannedMaintenance: Boolean!
    otherMaintenance: Boolean!
    maintenanceDesc: String!
    baseAndEquipment: Boolean!
    note: String!
  }
  # Input types
  input CreateDailyUpdateInput {
    flightId: Int!
    date: DateTime!
    wasFlight: Boolean!
    delay: Boolean!
    delayReason: String
    delayDesc: String
    maintenace: Boolean!
    plannedMaintenance: Boolean
    unplannedMaintenance: Boolean
    otherMaintenance: Boolean
    maintenanceDesc: String
    baseAndEquipment: Boolean!
    note: String
  }
  input UpdateDailyUpdateInput {
    flightId: Int
    date: DateTime
    wasFlight: Boolean
    delay: Boolean
    delayReason: String
    delayDesc: String
    maintenace: Boolean
    plannedMaintenance: Boolean
    unplannedMaintenance: Boolean
    otherMaintenance: Boolean
    maintenanceDesc: String
    baseAndEquipment: Boolean
    note: String
  }
`;

export default dailyUpdatesTypeDefs;
