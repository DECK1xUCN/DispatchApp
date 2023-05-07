import gql from "graphql-tag";

const dailyUpdateTypeDefs = gql`
  type DailyUpdate {
    id: Int!
    flight: Flight!
    wasFlight: Boolean!
    delay: Boolean!
    delayCode: String!
    delayTime: Int!
    delayDesc: String!
    maintenance: Boolean!
    plannedMaintenance: Boolean!
    unplannedMaintenance: Boolean!
    otherMaintenance: Boolean!
    maintenanceNote: String!
    baseAndEquipment: Boolean!
    note: String!
  }

  input CreateDailyUpdate {
    flightId: Int
    wasFlight: Boolean!
    delay: Boolean!
    delayCode: String
    delayTime: Int
    delayDesc: String
    maintenance: Boolean!
    plannedMaintenance: Boolean
    unplannedMaintenance: Boolean
    otherMaintenance: Boolean
    maintenanceNote: String
    baseAndEquipment: Boolean!
    note: String
  }

  type Query {
    dailyUpdate(id: Int!): DailyUpdate!
    dailyUpdates: [DailyUpdate!]!
  }

  type Mutation {
    createDailyUpdate(input: CreateDailyUpdate!): DailyUpdate!
  }

  type Query {
    dailyUpdate(id: Int!): DailyUpdate!
    dailyUpdates: [DailyUpdate!]!
  }

  type Mutation {
    createDailyUpdate(input: CreateDailyUpdate!): DailyUpdate!
  }

  type Query {
    dailyUpdate(id: Int!): DailyUpdate!
    dailyUpdates: [DailyUpdate!]!
  }

  type Mutation {
    createDailyUpdate(input: CreateDailyUpdate!): DailyUpdate!
  }
`;

export default dailyUpdateTypeDefs;
