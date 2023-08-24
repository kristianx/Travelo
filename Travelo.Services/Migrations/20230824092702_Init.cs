using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Travelo.Services.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Account",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Role = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Account", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Country",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Country", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Facility",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Facility", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Tag",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tag", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "TravelType",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TravelType", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "City",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CountryId = table.Column<int>(type: "int", nullable: false),
                    Image = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_City", x => x.Id);
                    table.ForeignKey(
                        name: "FK_City_Country_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Country",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Accomodations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: false),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PostalCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Images = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Accomodations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Accomodations_City_CityId",
                        column: x => x.CityId,
                        principalTable: "City",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Address",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    StreetAddress = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PostalCode = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: false),
                    CountryId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Address", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Address_City_CityId",
                        column: x => x.CityId,
                        principalTable: "City",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Address_Country_CountryId",
                        column: x => x.CountryId,
                        principalTable: "Country",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Agency",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    About = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Image = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    WebsiteUrl = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AccountId = table.Column<int>(type: "int", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: false),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PostalCode = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Agency", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Agency_Account_AccountId",
                        column: x => x.AccountId,
                        principalTable: "Account",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Agency_City_CityId",
                        column: x => x.CityId,
                        principalTable: "City",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "CityTag",
                columns: table => new
                {
                    TagsId = table.Column<int>(type: "int", nullable: false),
                    citiesId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CityTag", x => new { x.TagsId, x.citiesId });
                    table.ForeignKey(
                        name: "FK_CityTag_City_citiesId",
                        column: x => x.citiesId,
                        principalTable: "City",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_CityTag_Tag_TagsId",
                        column: x => x.TagsId,
                        principalTable: "Tag",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LastName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    Image = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    AccountId = table.Column<int>(type: "int", nullable: false),
                    CityId = table.Column<int>(type: "int", nullable: false),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PostalCode = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User", x => x.Id);
                    table.ForeignKey(
                        name: "FK_User_Account_AccountId",
                        column: x => x.AccountId,
                        principalTable: "Account",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_User_City_CityId",
                        column: x => x.CityId,
                        principalTable: "City",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "AccomodationFacility",
                columns: table => new
                {
                    AccomodationsId = table.Column<int>(type: "int", nullable: false),
                    FacilitiesId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AccomodationFacility", x => new { x.AccomodationsId, x.FacilitiesId });
                    table.ForeignKey(
                        name: "FK_AccomodationFacility_Accomodations_AccomodationsId",
                        column: x => x.AccomodationsId,
                        principalTable: "Accomodations",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_AccomodationFacility_Facility_FacilitiesId",
                        column: x => x.FacilitiesId,
                        principalTable: "Facility",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Trip",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AgencyId = table.Column<int>(type: "int", nullable: false),
                    AccomodationId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Trip", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Trip_Accomodations_AccomodationId",
                        column: x => x.AccomodationId,
                        principalTable: "Accomodations",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Trip_Agency_AgencyId",
                        column: x => x.AgencyId,
                        principalTable: "Agency",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "PaymentMethod",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CardNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    HolderName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CVV = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ExpDate = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Primary = table.Column<bool>(type: "bit", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaymentMethod", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PaymentMethod_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Rating",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RatingScore = table.Column<double>(type: "float", nullable: false),
                    TimeOfRating = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    TripId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rating", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Rating_Trip_TripId",
                        column: x => x.TripId,
                        principalTable: "Trip",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Rating_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TripItem",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CheckIn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CheckOut = table.Column<DateTime>(type: "datetime2", nullable: false),
                    PricePerPerson = table.Column<int>(type: "int", nullable: false),
                    TripId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TripItem", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TripItem_Trip_TripId",
                        column: x => x.TripId,
                        principalTable: "Trip",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TripUser",
                columns: table => new
                {
                    TripsId = table.Column<int>(type: "int", nullable: false),
                    UsersId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TripUser", x => new { x.TripsId, x.UsersId });
                    table.ForeignKey(
                        name: "FK_TripUser_Trip_TripsId",
                        column: x => x.TripsId,
                        principalTable: "Trip",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_TripUser_User_UsersId",
                        column: x => x.UsersId,
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Reservation",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TimeOfReservation = table.Column<DateTime>(type: "datetime2", nullable: false),
                    NumberOfAdults = table.Column<int>(type: "int", nullable: false),
                    NumberOfChildren = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    Price = table.Column<int>(type: "int", nullable: false),
                    TripItemId = table.Column<int>(type: "int", nullable: false),
                    TripId = table.Column<int>(type: "int", nullable: false),
                    AgencyId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reservation", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reservation_Agency_AgencyId",
                        column: x => x.AgencyId,
                        principalTable: "Agency",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Reservation_TripItem_TripItemId",
                        column: x => x.TripItemId,
                        principalTable: "TripItem",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Reservation_Trip_TripId",
                        column: x => x.TripId,
                        principalTable: "Trip",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Reservation_User_UserId",
                        column: x => x.UserId,
                        principalTable: "User",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "Account",
                columns: new[] { "Id", "Email", "PasswordHash", "PasswordSalt", "Role" },
                values: new object[,]
                {
                    { 1, "test@gmail.com", "Mb3xwhZo+rxBspxLceGrYNXQDl8=", "9rT9FTnj0y1PDoTwG1zkmg==", 0 },
                    { 2, "travelo@gmail.com", "Mb3xwhZo+rxBspxLceGrYNXQDl8=", "9rT9FTnj0y1PDoTwG1zkmg==", 1 },
                    { 3, "nova@gmail.com", "Mb3xwhZo+rxBspxLceGrYNXQDl8=", "9rT9FTnj0y1PDoTwG1zkmg==", 1 }
                });

            migrationBuilder.InsertData(
                table: "Country",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Bosnia and Herzegovina" },
                    { 2, "Croatia" },
                    { 3, "Serbia" },
                    { 4, "Austria" },
                    { 5, "France" }
                });

            migrationBuilder.InsertData(
                table: "Facility",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Spa" },
                    { 2, "Parking" },
                    { 3, "Surfing" },
                    { 4, "AC" },
                    { 5, "Wifi" },
                    { 6, "Bathroom" },
                    { 7, "Pets" },
                    { 8, "Pickup" },
                    { 9, "Pool" }
                });

            migrationBuilder.InsertData(
                table: "Tag",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Surfing" },
                    { 2, "Hot" },
                    { 3, "Summer" },
                    { 4, "Beach" },
                    { 5, "Cabins" },
                    { 6, "Camping" },
                    { 7, "Farms" },
                    { 8, "Skiing" }
                });

            migrationBuilder.InsertData(
                table: "City",
                columns: new[] { "Id", "CountryId", "Image", "Name" },
                values: new object[,]
                {
                    { 1, 1, null, "Zivinice" },
                    { 2, 1, null, "Mostar" },
                    { 3, 1, null, "Tuzla" },
                    { 4, 1, null, "Sarajevo" },
                    { 5, 2, null, "Zagreb" },
                    { 6, 2, null, "Split" },
                    { 7, 2, null, "Makarska" },
                    { 8, 2, null, "Zadar" },
                    { 9, 3, null, "Belgrade" },
                    { 10, 3, null, "Novi Sad" }
                });

            migrationBuilder.InsertData(
                table: "Accomodations",
                columns: new[] { "Id", "Address", "CityId", "Description", "Images", "Name", "PostalCode" },
                values: new object[,]
                {
                    { 1, "Stara Ilicka bb", 2, "Relaxed rooms with traditional decor offer Internet access, flat-screens, minifridges and safes, plus balconies. Upgraded rooms add living areas and whirlpool tubs. Elegant 3-bedroom apartments feature kitchens and dining areas. Room service is available.", null, "Hotel Bevanda", "88000" },
                    { 2, "Kralja Petra Kresimira", 7, "Located right next to the beach, Hotel Park Makarska offers an outdoor pool and a sun terrace, as well as an à-la-carte restaurant that serves international dishes. The hotel`s Spa and Wellness Center features a Finnish and Turkish sauna, a hydro massage bath and fitness room, as well as indoor pool. There you can enjoy integrated beauty programs, facial and body treatments and a rich selection of special massage techniques. Free WiFi access is available.", null, "Hotel Park", "21300" },
                    { 3, "Marsala Tita bb", 1, "Relaxed rooms with traditional decor offer Internet access, flat-screens, minifridges and safes, plus balconies. Upgraded rooms add living areas and whirlpool tubs. Elegant 3-bedroom apartments feature kitchens and dining areas. Room service is available.", null, "Motel Jet Star", "75270" },
                    { 4, "Dr. Pintola 23", 4, "Located close to Sarajevo's green district of Ilidza and 2 km from Sarajevo International Airport, Hollywood Hotel offers spacious and modern rooms with free WiFi, air conditioning and a bath or shower. Guests can use the hotel's indoor pool, sauna and fitness centre free of charge.", null, "Hollywood Hotel", "7100" },
                    { 5, "Avenija Dubrava 70,", 5, "Located in the eastern part of Zagreb right next to the tram stop, Hotel Residence is a 15-minute tram ride away from the city centre. Free Wi-Fi is available.\n\nResidence’s air-conditioned rooms are decorated in a very elegant and understated style. They feature marble bathrooms, a flat-screen TV with satellite channels and a minibar. Some rooms also include a hot tub.", null, "Hotel Residence", "10040" }
                });

            migrationBuilder.InsertData(
                table: "Agency",
                columns: new[] { "Id", "About", "AccountId", "Address", "CityId", "Image", "Name", "Phone", "PostalCode", "Status", "WebsiteUrl" },
                values: new object[,]
                {
                    { 1, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 2, "Mostarska 1", 2, null, "Travelo", "+38761234567", "88000", true, "travelo.ba" },
                    { 2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", 3, "Super Mocna Adresa 1", 4, null, "Nova Agencija", "+38761234567", "71000", true, "nova.ba" }
                });

            migrationBuilder.InsertData(
                table: "CityTag",
                columns: new[] { "TagsId", "citiesId" },
                values: new object[,]
                {
                    { 1, 6 },
                    { 1, 7 },
                    { 1, 8 },
                    { 2, 1 },
                    { 2, 2 },
                    { 2, 5 },
                    { 2, 6 },
                    { 2, 7 },
                    { 2, 8 },
                    { 3, 1 },
                    { 3, 2 },
                    { 3, 6 },
                    { 3, 7 },
                    { 3, 8 },
                    { 4, 6 },
                    { 4, 7 },
                    { 4, 8 },
                    { 5, 1 },
                    { 5, 2 },
                    { 5, 5 },
                    { 6, 2 },
                    { 6, 5 },
                    { 6, 6 },
                    { 6, 7 },
                    { 6, 8 }
                });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "Id", "AccountId", "Address", "CityId", "FirstName", "Image", "LastName", "PostalCode", "Status", "Username" },
                values: new object[] { 1, 1, "Mostarska 1", 2, "Tester", null, "Testerovic", "88000", true, "Tester" });

            migrationBuilder.InsertData(
                table: "AccomodationFacility",
                columns: new[] { "AccomodationsId", "FacilitiesId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 1, 2 },
                    { 1, 3 },
                    { 1, 4 },
                    { 1, 5 },
                    { 1, 6 },
                    { 1, 7 },
                    { 1, 8 },
                    { 1, 9 },
                    { 2, 1 },
                    { 2, 2 },
                    { 2, 3 },
                    { 2, 4 },
                    { 2, 5 },
                    { 2, 6 },
                    { 2, 8 },
                    { 2, 9 },
                    { 3, 1 },
                    { 3, 2 },
                    { 3, 3 },
                    { 3, 4 },
                    { 3, 5 },
                    { 3, 6 },
                    { 3, 8 },
                    { 4, 1 },
                    { 4, 2 },
                    { 4, 3 },
                    { 4, 4 },
                    { 4, 5 },
                    { 4, 6 },
                    { 4, 9 },
                    { 5, 1 },
                    { 5, 2 },
                    { 5, 3 },
                    { 5, 4 },
                    { 5, 5 },
                    { 5, 6 },
                    { 5, 7 },
                    { 5, 8 },
                    { 5, 9 }
                });

            migrationBuilder.InsertData(
                table: "Trip",
                columns: new[] { "Id", "AccomodationId", "AgencyId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 1 },
                    { 3, 3, 2 },
                    { 4, 4, 2 },
                    { 5, 5, 2 }
                });

            migrationBuilder.InsertData(
                table: "Rating",
                columns: new[] { "Id", "RatingScore", "TimeOfRating", "TripId", "UserId" },
                values: new object[,]
                {
                    { 1, 5.0, new DateTime(2023, 8, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1 },
                    { 2, 4.0, new DateTime(2023, 7, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 1 },
                    { 3, 5.0, new DateTime(2023, 6, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 1 },
                    { 4, 1.0, new DateTime(2023, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, 1 }
                });

            migrationBuilder.InsertData(
                table: "TripItem",
                columns: new[] { "Id", "CheckIn", "CheckOut", "PricePerPerson", "TripId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 99, 1 },
                    { 2, new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), 99, 1 },
                    { 3, new DateTime(2023, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 80, 1 },
                    { 4, new DateTime(2023, 8, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 150, 2 },
                    { 5, new DateTime(2023, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 150, 2 },
                    { 6, new DateTime(2023, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 200, 3 },
                    { 7, new DateTime(2023, 8, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 250, 4 },
                    { 8, new DateTime(2023, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 300, 4 },
                    { 9, new DateTime(2023, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 4, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 100, 5 },
                    { 10, new DateTime(2023, 8, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2023, 8, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), 100, 5 }
                });

            migrationBuilder.InsertData(
                table: "Reservation",
                columns: new[] { "Id", "AgencyId", "NumberOfAdults", "NumberOfChildren", "Price", "TimeOfReservation", "TripId", "TripItemId", "UserId" },
                values: new object[,]
                {
                    { 1, null, 2, 0, 3600, new DateTime(2023, 6, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, 6, 1 },
                    { 2, null, 1, 0, 990, new DateTime(2023, 5, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 1, 1 },
                    { 3, null, 2, 0, 800, new DateTime(2023, 6, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 1, 3, 1 },
                    { 4, null, 3, 1, 3000, new DateTime(2023, 6, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 4, 1 },
                    { 5, null, 2, 1, 4050, new DateTime(2023, 6, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), 2, 5, 1 },
                    { 6, null, 2, 0, 3000, new DateTime(2023, 2, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 5, 9, 1 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_AccomodationFacility_FacilitiesId",
                table: "AccomodationFacility",
                column: "FacilitiesId");

            migrationBuilder.CreateIndex(
                name: "IX_Accomodations_CityId",
                table: "Accomodations",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Address_CityId",
                table: "Address",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Address_CountryId",
                table: "Address",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_Agency_AccountId",
                table: "Agency",
                column: "AccountId");

            migrationBuilder.CreateIndex(
                name: "IX_Agency_CityId",
                table: "Agency",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_City_CountryId",
                table: "City",
                column: "CountryId");

            migrationBuilder.CreateIndex(
                name: "IX_CityTag_citiesId",
                table: "CityTag",
                column: "citiesId");

            migrationBuilder.CreateIndex(
                name: "IX_PaymentMethod_UserId",
                table: "PaymentMethod",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Rating_TripId",
                table: "Rating",
                column: "TripId");

            migrationBuilder.CreateIndex(
                name: "IX_Rating_UserId",
                table: "Rating",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_AgencyId",
                table: "Reservation",
                column: "AgencyId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_TripId",
                table: "Reservation",
                column: "TripId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_TripItemId",
                table: "Reservation",
                column: "TripItemId");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_UserId",
                table: "Reservation",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Trip_AccomodationId",
                table: "Trip",
                column: "AccomodationId");

            migrationBuilder.CreateIndex(
                name: "IX_Trip_AgencyId",
                table: "Trip",
                column: "AgencyId");

            migrationBuilder.CreateIndex(
                name: "IX_TripItem_TripId",
                table: "TripItem",
                column: "TripId");

            migrationBuilder.CreateIndex(
                name: "IX_TripUser_UsersId",
                table: "TripUser",
                column: "UsersId");

            migrationBuilder.CreateIndex(
                name: "IX_User_AccountId",
                table: "User",
                column: "AccountId");

            migrationBuilder.CreateIndex(
                name: "IX_User_CityId",
                table: "User",
                column: "CityId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AccomodationFacility");

            migrationBuilder.DropTable(
                name: "Address");

            migrationBuilder.DropTable(
                name: "CityTag");

            migrationBuilder.DropTable(
                name: "PaymentMethod");

            migrationBuilder.DropTable(
                name: "Rating");

            migrationBuilder.DropTable(
                name: "Reservation");

            migrationBuilder.DropTable(
                name: "TravelType");

            migrationBuilder.DropTable(
                name: "TripUser");

            migrationBuilder.DropTable(
                name: "Facility");

            migrationBuilder.DropTable(
                name: "Tag");

            migrationBuilder.DropTable(
                name: "TripItem");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "Trip");

            migrationBuilder.DropTable(
                name: "Accomodations");

            migrationBuilder.DropTable(
                name: "Agency");

            migrationBuilder.DropTable(
                name: "Account");

            migrationBuilder.DropTable(
                name: "City");

            migrationBuilder.DropTable(
                name: "Country");
        }
    }
}
