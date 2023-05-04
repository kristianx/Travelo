using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Travelo.Services.Migrations
{
    /// <inheritdoc />
    public partial class Facilities_UsersBookmarks : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Facility_Accommodations_AccommodationId",
                table: "Facility");

            migrationBuilder.DropIndex(
                name: "IX_Facility_AccommodationId",
                table: "Facility");

            migrationBuilder.DropColumn(
                name: "AccommodationId",
                table: "Facility");

            migrationBuilder.CreateTable(
                name: "AccommodationFacility",
                columns: table => new
                {
                    AccomodationsId = table.Column<int>(type: "int", nullable: false),
                    FacilitiesId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AccommodationFacility", x => new { x.AccomodationsId, x.FacilitiesId });
                    table.ForeignKey(
                        name: "FK_AccommodationFacility_Accommodations_AccomodationsId",
                        column: x => x.AccomodationsId,
                        principalTable: "Accommodations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AccommodationFacility_Facility_FacilitiesId",
                        column: x => x.FacilitiesId,
                        principalTable: "Facility",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
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
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TripUser_User_UsersId",
                        column: x => x.UsersId,
                        principalTable: "User",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AccommodationFacility_FacilitiesId",
                table: "AccommodationFacility",
                column: "FacilitiesId");

            migrationBuilder.CreateIndex(
                name: "IX_TripUser_UsersId",
                table: "TripUser",
                column: "UsersId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AccommodationFacility");

            migrationBuilder.DropTable(
                name: "TripUser");

            migrationBuilder.AddColumn<int>(
                name: "AccommodationId",
                table: "Facility",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Facility_AccommodationId",
                table: "Facility",
                column: "AccommodationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Facility_Accommodations_AccommodationId",
                table: "Facility",
                column: "AccommodationId",
                principalTable: "Accommodations",
                principalColumn: "Id");
        }
    }
}
