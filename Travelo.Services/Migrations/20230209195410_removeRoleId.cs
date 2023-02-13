using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Travelo.Services.Migrations
{
    /// <inheritdoc />
    public partial class removeRoleId : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RoleId",
                table: "Account");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "RoleId",
                table: "Account",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
