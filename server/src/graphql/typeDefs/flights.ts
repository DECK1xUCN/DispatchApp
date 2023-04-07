import gql from "graphql-tag";

const flightTypeDefs = gql`
  type Query {
    flights: [Flight!]!
    flight(id: Int!): Flight!
  }
  type Mutation {
    createFlight(data: CreateFlightInput): Flight!
    updateFlight(id: Int!, data: UpdateFlightInput!): Flight!
  }
  type Flight {
    id: Int!
    flightNumber: String!
    from: Heliport!
    via: [Site!]!
    to: Heliport!
    etd: DateTime!
    rotorStart: DateTime!
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime!
    ata: DateTime!
    blockTime: Int!
    flightTime: Int!
    delay: Boolean!
    delayMin: Int!
    delayCode: String!
    delayDesc: String!
    pax: Int!
    paxTax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    notes: String!
    dailyReport: DailyReport!
    dailyUpdate: DailyUpdate
  }

  # Input types
  input CreateFlightInput {
    flightNumber: String!
    fromId: Int!
    viaId: Int!
    toId: Int!
    etd: DateTime!
    rotorStart: DateTime
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime
    ata: DateTime
    blockTime: Int
    flightTime: Int
    delay: Boolean!
    delayMin: Int
    delayCode: String
    delayDesc: String
    pax: Int!
    paxTax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    notes: String
    dailyReportId: Int!
    dailyUpdateId: Int
  }
  input UpdateFlightInput {
    flightNumber: String
    fromId: Int
    toId: Int
    etd: DateTime
    rotorStart: DateTime
    atd: DateTime
    eta: DateTime
    rotorStop: DateTime
    ata: DateTime
    blockTime: Int
    flightTime: Int
    delay: Boolean
    delayMin: Int
    delayCode: String
    delayDesc: String
    pax: Int
    paxTax: Int
    cargoPP: Int
    hoistCycles: Int
    notes: String
    dailyReportId: Int!
    dailyUpdateId: Int
  }
  scalar DateTime
`;

export default flightTypeDefs;
