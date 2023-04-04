import gql from "graphql-tag";

const flightTypeDefs = gql`
  type Query {
    findAllFlights: [Flight!]!
    findFlightById(id: String!): Flight!
    findFlightByFlightNumber(flightNumber: String!): Flight!
  }
  type Mutation {
    createFlight(data: FlightCreateInput): Flight!
    updateFlightById(id: String!, data: FlightUpdateInput!): Flight!
    updateFlightByFlightNumber(
      flightNumber: String!
      data: FlightUpdateInput!
    ): Flight!
  }

  type Flight {
    id: String!
    flightNumber: String!
    from: String!
    via: String!
    to: String!
    etd: DateTime!
    rotorStart: DateTime!
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime!
    ata: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    latenote: String
    delayCode: String
  }

  # Input types
  input FlightCreateInput {
    from: String!
    flightNumber: String!
    via: String!
    to: String!
    etd: DateTime!
    rotorStart: DateTime!
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime!
    ata: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    latenote: String
    delayCode: String
  }

  input FlightUpdateInput {
    from: String!
    flightNumber: String!
    via: String!
    to: String!
    etd: DateTime!
    rotorStart: DateTime!
    atd: DateTime!
    eta: DateTime!
    rotorStop: DateTime!
    ata: DateTime!
    pax: Int!
    cargoPP: Int!
    hoistCycles: Int!
    late: Boolean!
    lateNote: String
    delayCode: String
  }

  scalar DateTime
`;

export default flightTypeDefs;
