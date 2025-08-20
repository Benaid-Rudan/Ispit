using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eCommerce.Services.Migrations
{
    /// <inheritdoc />
    public partial class ispitniPrimjer : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "RadniProstor",
                columns: table => new
                {
                    RadniProstorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Oznaka = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Kapacitet = table.Column<int>(type: "int", nullable: false),
                    Aktivna = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RadniProstor", x => x.RadniProstorId);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijaProstora",
                columns: table => new
                {
                    RezervacijaProstoraId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    RadniProstorId = table.Column<int>(type: "int", nullable: false),
                    DatumRezervacije = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TrajanjeRezervacije = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    Napomena = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaProstora", x => x.RezervacijaProstoraId);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora_RadniProstor_RadniProstorId",
                        column: x => x.RadniProstorId,
                        principalTable: "RadniProstor",
                        principalColumn: "RadniProstorId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijaProstora_Users_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora_KorisnikId",
                table: "RezervacijaProstora",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaProstora_RadniProstorId",
                table: "RezervacijaProstora",
                column: "RadniProstorId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijaProstora");

            migrationBuilder.DropTable(
                name: "RadniProstor");
        }
    }
}
