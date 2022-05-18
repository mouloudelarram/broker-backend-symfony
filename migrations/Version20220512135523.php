<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20220512135523 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE image DROP FOREIGN KEY FK_C53D045FF675F31B');
        $this->addSql('ALTER TABLE image ADD CONSTRAINT FK_C53D045FF675F31B FOREIGN KEY (author_id) REFERENCES user (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE item DROP FOREIGN KEY FK_1F1B251EF675F31B');
        $this->addSql('ALTER TABLE item DROP FOREIGN KEY FK_1F1B251EBCF5E72D');
        $this->addSql('ALTER TABLE item ADD CONSTRAINT FK_1F1B251EF675F31B FOREIGN KEY (author_id) REFERENCES user (id) ON DELETE SET NULL');
        $this->addSql('ALTER TABLE item ADD CONSTRAINT FK_1F1B251EBCF5E72D FOREIGN KEY (categorie_id) REFERENCES categorie (id) ON DELETE SET NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE image DROP FOREIGN KEY FK_C53D045FF675F31B');
        $this->addSql('ALTER TABLE image ADD CONSTRAINT FK_C53D045FF675F31B FOREIGN KEY (author_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE item DROP FOREIGN KEY FK_1F1B251EF675F31B');
        $this->addSql('ALTER TABLE item DROP FOREIGN KEY FK_1F1B251EBCF5E72D');
        $this->addSql('ALTER TABLE item ADD CONSTRAINT FK_1F1B251EF675F31B FOREIGN KEY (author_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE item ADD CONSTRAINT FK_1F1B251EBCF5E72D FOREIGN KEY (categorie_id) REFERENCES categorie (id)');
    }
}
