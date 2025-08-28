using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eCommerce.Services.Migrations
{
    /// <inheritdoc />
    public partial class testIspit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RezervacijaProstora");

            migrationBuilder.DropTable(
                name: "RadniProstor");

            migrationBuilder.CreateTable(
                name: "Challenge",
                columns: table => new
                {
                    ChallengeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TipIzazova = table.Column<int>(type: "int", nullable: false),
                    PraviloUspjeha = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Challenge", x => x.ChallengeId);
                });

            migrationBuilder.CreateTable(
                name: "PeerChallenge",
                columns: table => new
                {
                    PeerChallengeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IzazivacId = table.Column<int>(type: "int", nullable: false),
                    IzazvaniId = table.Column<int>(type: "int", nullable: false),
                    ChallengeId = table.Column<int>(type: "int", nullable: false),
                    StatusPeer = table.Column<int>(type: "int", nullable: false),
                    DatumKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PeerChallenge", x => x.PeerChallengeId);
                    table.ForeignKey(
                        name: "FK_PeerChallenge_Challenge_ChallengeId",
                        column: x => x.ChallengeId,
                        principalTable: "Challenge",
                        principalColumn: "ChallengeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PeerChallenge_Users_IzazivacId",
                        column: x => x.IzazivacId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_PeerChallenge_Users_IzazvaniId",
                        column: x => x.IzazvaniId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "UserChallenge",
                columns: table => new
                {
                    UserChallengeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IzazvaniId = table.Column<int>(type: "int", nullable: false),
                    ChallengeId = table.Column<int>(type: "int", nullable: false),
                    DatumPrihvatanja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    StatusIzazov = table.Column<int>(type: "int", nullable: false),
                    Napredak = table.Column<int>(type: "int", nullable: false),
                    VrijemeZavrsetka = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserChallenge", x => x.UserChallengeId);
                    table.ForeignKey(
                        name: "FK_UserChallenge_Challenge_ChallengeId",
                        column: x => x.ChallengeId,
                        principalTable: "Challenge",
                        principalColumn: "ChallengeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserChallenge_Users_IzazvaniId",
                        column: x => x.IzazvaniId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PeerChallenge_ChallengeId",
                table: "PeerChallenge",
                column: "ChallengeId");

            migrationBuilder.CreateIndex(
                name: "IX_PeerChallenge_IzazivacId",
                table: "PeerChallenge",
                column: "IzazivacId");

            migrationBuilder.CreateIndex(
                name: "IX_PeerChallenge_IzazvaniId",
                table: "PeerChallenge",
                column: "IzazvaniId");

            migrationBuilder.CreateIndex(
                name: "IX_UserChallenge_ChallengeId",
                table: "UserChallenge",
                column: "ChallengeId");

            migrationBuilder.CreateIndex(
                name: "IX_UserChallenge_IzazvaniId",
                table: "UserChallenge",
                column: "IzazvaniId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PeerChallenge");

            migrationBuilder.DropTable(
                name: "UserChallenge");

            migrationBuilder.DropTable(
                name: "Challenge");

            migrationBuilder.CreateTable(
                name: "RadniProstor",
                columns: table => new
                {
                    RadniProstorId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Aktivna = table.Column<bool>(type: "bit", nullable: false),
                    Kapacitet = table.Column<int>(type: "int", nullable: false),
                    Oznaka = table.Column<string>(type: "nvarchar(max)", nullable: false)
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
                    Napomena = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    StatusRezervacije = table.Column<int>(type: "int", nullable: false),
                    Trajanje = table.Column<int>(type: "int", nullable: false)
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
    }
}
