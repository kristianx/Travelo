using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Travelo.Services.Migrations
{
    /// <inheritdoc />
    public partial class TagsChange : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tag_City_CityId",
                table: "Tag");

            migrationBuilder.DropForeignKey(
                name: "FK_Tag_Trip_TripId",
                table: "Tag");

            migrationBuilder.DropIndex(
                name: "IX_Tag_CityId",
                table: "Tag");

            migrationBuilder.DropIndex(
                name: "IX_Tag_TripId",
                table: "Tag");

            migrationBuilder.DropColumn(
                name: "CityId",
                table: "Tag");

            migrationBuilder.DropColumn(
                name: "TripId",
                table: "Tag");

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
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_CityTag_Tag_TagsId",
                        column: x => x.TagsId,
                        principalTable: "Tag",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "TagTrip",
                columns: table => new
                {
                    TagsId = table.Column<int>(type: "int", nullable: false),
                    tripsId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TagTrip", x => new { x.TagsId, x.tripsId });
                    table.ForeignKey(
                        name: "FK_TagTrip_Tag_TagsId",
                        column: x => x.TagsId,
                        principalTable: "Tag",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_TagTrip_Trip_tripsId",
                        column: x => x.tripsId,
                        principalTable: "Trip",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CityTag_citiesId",
                table: "CityTag",
                column: "citiesId");

            migrationBuilder.CreateIndex(
                name: "IX_TagTrip_tripsId",
                table: "TagTrip",
                column: "tripsId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CityTag");

            migrationBuilder.DropTable(
                name: "TagTrip");

            migrationBuilder.AddColumn<int>(
                name: "CityId",
                table: "Tag",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "TripId",
                table: "Tag",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Tag_CityId",
                table: "Tag",
                column: "CityId");

            migrationBuilder.CreateIndex(
                name: "IX_Tag_TripId",
                table: "Tag",
                column: "TripId");

            migrationBuilder.AddForeignKey(
                name: "FK_Tag_City_CityId",
                table: "Tag",
                column: "CityId",
                principalTable: "City",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Tag_Trip_TripId",
                table: "Tag",
                column: "TripId",
                principalTable: "Trip",
                principalColumn: "Id");
        }
    }
}
