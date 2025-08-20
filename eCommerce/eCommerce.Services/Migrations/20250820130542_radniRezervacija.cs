using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eCommerce.Services.Migrations
{
    /// <inheritdoc />
    public partial class radniRezervacija : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MoodTracker");

            migrationBuilder.DropColumn(
                name: "TrajanjeRezervacije",
                table: "RezervacijaProstora");

            migrationBuilder.RenameColumn(
                name: "Status",
                table: "RezervacijaProstora",
                newName: "Trajanje");

            migrationBuilder.AddColumn<int>(
                name: "StatusRezervacije",
                table: "RezervacijaProstora",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "StatusRezervacije",
                table: "RezervacijaProstora");

            migrationBuilder.RenameColumn(
                name: "Trajanje",
                table: "RezervacijaProstora",
                newName: "Status");

            migrationBuilder.AddColumn<string>(
                name: "TrajanjeRezervacije",
                table: "RezervacijaProstora",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "MoodTracker",
                columns: table => new
                {
                    MoodTrackerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    DatumEvidencije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Vrijednost = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MoodTracker", x => x.MoodTrackerId);
                    table.ForeignKey(
                        name: "FK_MoodTracker_Users_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_MoodTracker_KorisnikId",
                table: "MoodTracker",
                column: "KorisnikId");
        }
    }
}
